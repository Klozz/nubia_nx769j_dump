#!/system/bin/sh

trace_log_dir=/data/local/vendor_logs
cd ${trace_log_dir}/logcat/
if [ "x$(getprop persist.sys.ztelog.enable)" != "x1" ]; then
    exit 0
fi

local tt=`date +%G%m%d_%H%M%S`

# add for dump mem leaked proc
local leaked_pid=`getprop sys.lmk.leaked_pid`
if [ "$leaked_pid" -gt "0" ]; then
    local file_dump_leaked_pid=dumpsys_meminfo_${leaked_pid}_${tt}.txt
    dumpsys -t 60 meminfo $leaked_pid > $file_dump_leaked_pid
fi
setprop sys.lmk.leaked_pid 0
#
