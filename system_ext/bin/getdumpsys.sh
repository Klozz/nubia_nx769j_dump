#!/system/bin/sh

trace_log_dir=/data/local/vendor_logs
if [ "x$(getprop persist.sys.ztelog.enable)" != "x1" ]; then
    exit 0
fi

local reason=$(getprop debug.systrace.reason)
local jank=$(getprop init.svc.jankdumpsystrace)
if [ "$jank" = "running" ] ; then
        reason="jank"
fi
local trim_reason=${reason/\//\.}

cd ${trace_log_dir}/logcat/ || exit

#
# add for display dumpsys
#
if [ ! -n "$trim_reason" ]; then
    rm -fr dumpsys_screenshots.txt
    echo "begin time: "$(date +%G%m%d_%T.%N) >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    echo "        dumpsys window" >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    dumpsys -t 30 window -a >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    echo "        dumpsys display" >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    dumpsys -t 30 display -a >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    echo "        dumpsys power" >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    dumpsys -t 30 power -a >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    echo "        dumpsys input" >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    dumpsys -t 30 input -a >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    echo "        dumpsys input_method" >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    dumpsys -t 30 input_method -a >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    echo "        dumpsys SurfaceFlinger" >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    dumpsys -t 30 SurfaceFlinger -a >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    echo "        dumpsys activity recents" >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    dumpsys -t 30 activity recents >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    echo "        dumpsys activity broadcasts" >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    dumpsys -t 30 activity broadcasts >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    echo "        dumpsys activity activities" >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    dumpsys -t 30 activity activities >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    echo "        dumpsys activity service SystemUIService" >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    dumpsys -t 30 activity service SystemUIService >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    echo "        dumpsys alarm" >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    dumpsys -t 30 alarm -a >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    echo "        dumpsys jobscheduler" >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    dumpsys -t 30 jobscheduler -a >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    echo "        dumpsys notification" >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    dumpsys -t 30 notification -a >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    echo "        dumpsys sensorservice" >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    dumpsys -t 30 sensorservice >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    echo "        dumpsys meminfo" >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    dumpsys -t 30 meminfo -S >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    echo "        dumpsys activity activities" >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    dumpsys -t 30 activity activities >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    echo "        dumpsys GameAssistService" >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    dumpsys -t 30 activity service GameAssistService >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    echo "        dumpsys FanService" >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    dumpsys -t 30 activity service FanService >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    echo "        dumpsys KeyMapCenterService" >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    dumpsys -t 30 activity service KeyMapCenterService >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    echo "        dumpsys GameHandleService" >> dumpsys_screenshots.txt
    echo "----------------------------------------" >> dumpsys_screenshots.txt
    dumpsys -t 30 activity service GameHandleService >> dumpsys_screenshots.txt

    if [ $(whoami) = "root" ];then
        temp=$(date +%G%m%d_%T)
        temp=$(echo "$temp" | sed 's/:/-/g')
        iptabledir="data/netcontrol_${temp}"
        mkdir -p "$iptabledir"

        iptables -nvL  > "${iptabledir}/iptables-filter.txt"
        iptables-save > "${iptabledir}/iptables-save.txt"
        ifconfig > "${iptabledir}/ifconfig.txt"
        ip rule > "${iptabledir}/iprule.txt"
        ip route > "${iptabledir}/iproute.txt"

        {
                echo "dumpsys connectivity  trafficcontroller"
                echo "----------------------------------------"
                dumpsys -t 30 connectivity  trafficcontroller
        } > "${iptabledir}/trafficcontroller.txt"

        ss -tpaen -o state established > "${iptabledir}/ss.txt"
    fi

    echo "end time: "$(date +%G%m%d_%T.%N) >> dumpsys_screenshots.txt
    chmod 755 dumpsys_screenshots.txt
fi
