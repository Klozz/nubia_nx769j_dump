#!/system/bin/sh

# zte avoid dup atrace2 or perfetto running, -n for not null or exist
atrace2pid=`pidof atrace2`
if [ -n "$atrace2pid" ] ; then exit 0; fi

trace_log_dir=/data/local/vendor_logs
if [ "x$(getprop persist.sys.ztelog.enable)" != "x1" ]; then
    if [ "x$(getprop persist.sys.systrace.enable)" != "x1" ]; then
        exit 0
    fi
fi

# zte add state for using perfetto instead of systrace, the latter is default case
use_atrace2_str="1"
if [ "x$(getprop debug.atrace.perferro_overrided)" = "x1" ]; then
    use_atrace2_str="0"
fi

#add by 10292412 for TP test
if [ -f "/.home" ] ; then
    /system/bin/get_tp_noise&
fi

if [ ! -f "/.cell" ] ; then
    /system/bin/get_tp_noise&
fi

MemTotalStr=`cat /proc/meminfo | /system/bin/grep MemTotal`
MemTotal=${MemTotalStr:16:8}
if [ $MemTotal -lt 800000 ]; then
    echo "dumptracer.sh exit becasue MemTotal = $MemTotal"
    exit 0
fi

# only do when use atrace2
if [ "x${use_atrace2_str}" = "x1" ]; then
    systracing_is_running=$(cat /sys/kernel/tracing/tracing_on)
    if [ "$systracing_is_running" -eq "0" ]; then
        echo "trace off and reopening ..."
        start atrace2 &
        # enough time to wait trace reopen then
        sleep 6
        echo "trace should be reopened"
        exit 0
    fi
fi

local reason=`getprop debug.systrace.reason`

local jank=`getprop init.svc.jankdumpsystrace`
if [ "$jank" = "running" ] ; then
        reason="jank"
fi

local tt=`date +%G%m%d_%H%M%S`
local trim_reason=${reason/\//\.}
local trace_file_name=systrace.${tt}.${trim_reason}.txt
if [ "$trim_reason" = "Healthy_Game" ] ; then
    trace_file_name=`getprop debug.systrace.filename`
    trace_log_dir=/data/nubiahealth/trace/
    if [ ! -d ${trace_log_dir}/logcat ]; then
        mkdir ${trace_log_dir}/logcat
        chown system.root ${trace_log_dir}/logcat/
        chmod 777 ${trace_log_dir}/logcat/
    fi
fi

local file=${trace_log_dir}/logcat/$trace_file_name
cd ${trace_log_dir}/logcat/

#getenforce|grep Enforcing

#if $busybox [ $? -eq 0 ]; then
#    echo "enforceing..."
#cat /sys/kernel/tracing/trace > $file
#else
#    atrace -c -b 8192 -t 3600000 gfx wm view webview mdss am res app sched freq dalvik input message binder action memreclaim --async_dump -z -o $file
#fi

if [ "x${use_atrace2_str}" = "x1" ]; then
    time=$(date "+%T.%N")
    echo "B|0000|***systrace dump timestamp is $time***" > /sys/kernel/tracing/trace_marker

    # zte systrace, stop tracing and app tags then get systrace, the trace data will be lost during this period
    echo 0 > /sys/kernel/tracing/tracing_on
    bak_tags=$(getprop debug.atrace.tags.enableflags)
    setprop debug.atrace.tags.enableflags 0
    atrace2 --async_dump -z -o "${file}" -m 3276800
    setprop debug.atrace.tags.enableflags "${bak_tags}"
    echo 1 > /sys/kernel/tracing/tracing_on
else
    if [ "x$(getprop debug.atrace.user_initiated)" = "x1" ]; then
        atrace2 --async_stop
        # wait enough for user initiated to empty
        sleep 8
        # not expected got data to output file
        # perfetto --txt --config /data/misc/perfetto-configs/perfetto_bugreport.cfg --out /data/misc/perfetto-traces/trace_null.tmp
        start perfetto_trace_configure &
        # skipped this time get trace data
    else
        perfetto2pid=$(pidof perfetto)
        if [ -n "$perfetto2pid" ] ; then
            # exist then try to get data
            perfetto --save-for-bugreport
            # cp "/data/misc/perfetto-traces/systrace.tmp" "${file}"
            cp "/data/misc/perfetto-traces/bugreport/systrace.pftrace" "${file}"

            sleep 2

            perfetto2pid=$(pidof perfetto)
            # expected after save bugreport
            if [ -z "$perfetto2pid" ] ; then
                start perfetto_trace_configure &
            fi
        else
            # not expected, just try to start again
            start perfetto_trace_configure &
        fi
    fi
fi

# the below may take too long time, so do it after catching trace
/system_ext/bin/snapshotwhenpull.sh

dumpsys scenedecision -appInfoTable > ${trace_log_dir}/logcat/dump_appInfoTable.csv
dumpsys scenedecision -appSettingsTable > ${trace_log_dir}/logcat/dump_appSettingsTable.csv

echo $trim_reason | grep "watchdog"
if [ $? -eq 0 ]; then
    echo "----------------------------------------" >> dumpsys_log.txt
    echo "        dumpsys activity all" >> dumpsys_log.txt
    echo "----------------------------------------" >> dumpsys_log.txt
    dumpsys -t 30 activity -v all >> dumpsys_log.txt
    echo "----------------------------------------" >> dumpsys_log.txt
    echo "        dumpsys activity service all" >> dumpsys_log.txt
    echo "----------------------------------------" >> dumpsys_log.txt
    dumpsys -t 30 activity service all >> dumpsys_log.txt
    echo "----------------------------------------" >> dumpsys_log.txt
    echo "        dumpsys activity provider all" >> dumpsys_log.txt
    echo "----------------------------------------" >> dumpsys_log.txt
    dumpsys -t 30 activity provider all >> dumpsys_log.txt

    if [ -d /d/binder ];then
        tar zcf $file.tar.gz $trace_file_name dumpsys_log.txt /d/binder
    else
        tar zcf $file.tar.gz $trace_file_name dumpsys_log.txt
    fi
    rm -fr $file events.txt mainsystem.txt dumpsys_log.txt
else
    tar zcf $file.tar.gz $trace_file_name 
    rm -fr $file events.txt mainsystem.txt
fi
chmod 755 $file.tar.gz

mkdir /sdcard/systrace/

funi=0
local filelimit=3
if [ "$trim_reason" = "Healthy_Game" ] ; then
    filelimit=100
fi
for file in `ls ${trace_log_dir}/logcat/systrace.*.gz | sort -nr`
do
    funi=`expr $funi + 1`
    if [ "$funi" -gt $filelimit ]; then
        if [ "x$(getprop persist.backtrace.threshold)" != "x" ]; then
            mv $file /sdcard/systrace/
        fi
        rm -fr $file
        echo $file
    fi
done

funi=0
for file in `ls /sdcard/systrace/systrace.*.gz | sort -nr`
do
funi=`expr $funi + 1`
if [ "$funi" -gt "60" ]; then
  rm -fr $file
  echo $file
fi
done

#add by 10292412 for TP test
funi=0
for file in `ls /data/local/vendor_logs/logcat/tprawdata/get_noisedata*.txt | sort -nr`
do
funi=`expr $funi + 1`
if [ "$funi" -gt "60" ]; then
  rm -fr $file
  echo $file
fi
done

if [ "$trim_reason" = "Healthy_Game" ] ; then
    setprop debug.systrace.filename ""
fi
setprop debug.systrace.reason ""

