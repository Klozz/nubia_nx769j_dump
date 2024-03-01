#!/system/bin/sh

function start_persist_atrace()
{
#    supolicy --live "allow tracer system_file:file entrypoint;"
    /system/bin/atrace2 -c -b 5120 -t3600000 gfx wm view webview am res sched freq dalvik input memreclaim workq mmc disk --async_start
}


if [ "x$(getprop persist.sys.ztelog.enable)" != "x1" ]; then
    exit 0
fi

################################################################
# Don't enable systrace when the total memory is below 800MB
MemTotalStr=`cat /proc/meminfo | /system/bin/grep MemTotal`
MemTotal=${MemTotalStr:16:8}
echo "MemTotal==$MemTotal"
if [ $MemTotal -lt 800000 ]; then
    echo "start_tracer.sh exit becasue MemTotal = $MemTotal"
    exit 0
fi

# qualcomm requires trace events open for stability issues
# the overriding or mixing should be valid only for specific test or device
# under control by persist properties, and the use of overriding is prefered
if [ "$(getprop persist.sys.sta_tr.irq)" -eq "1" ]; then
	echo 1 > /sys/kernel/tracing/events/irq/enable
	echo 1 > /sys/kernel/tracing/events/irq/irq_handler_entry/enable
	echo 1 > /sys/kernel/tracing/events/irq/irq_handler_exit/enable
	echo 1 > /sys/kernel/tracing/events/irq/softirq_entry/enable
	echo 1 > /sys/kernel/tracing/events/irq/softirq_exit/enable
	echo 1 > /sys/kernel/tracing/events/irq/softirq_raise/enable
fi
if [ "$(getprop persist.sys.sta_tr.sched)" -eq "1" ]; then
	echo 1 > /sys/kernel/tracing/events/sched/sched_switch/enable
	echo 1 > /sys/kernel/tracing/events/sched/sched_wakeup/enable
	echo 1 > /sys/kernel/tracing/events/sched/sched_wakeup_new/enable
	echo 1 > /sys/kernel/tracing/events/sched/sched_migrate_task/enable
#   30M percpu buffer, the default value is 1410K for example
#   And may be overrided by atrace2 -b 4096 if mixing mode is using
	echo 30720 > /sys/kernel/tracing/buffer_size_kb
fi
# if overriding config, then open trace right now
if [ "$(getprop persist.sys.sta_tr.override)" -eq "1" ]; then
    echo 1 > /sys/kernel/tracing/tracing_on
    exit 0
fi

echo 4096 > /sys/kernel/tracing/saved_cmdlines_size

local getsystrace=`getprop init.svc.getsystrace`
local systracing_is_running=`cat /sys/kernel/tracing/tracing_on`
if [ "$getsystrace" != "running" ]; then
    if [ "$systracing_is_running" -eq "0" ]; then
        setprop sys.check.interval 500
        sleep 8
        start_persist_atrace
        exit 0
    fi
fi


local tt=`date +%G%m%d_%H%M%S`

