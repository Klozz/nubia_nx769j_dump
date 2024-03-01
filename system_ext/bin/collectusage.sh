#!/system/bin/sh
local cpufile=//data/local/vendor_logs/logcat/summary/cpu.txt
local usagefile=//data/local/vendor_logs/logcat/summary/usage.txt
local memfile=//data/local/vendor_logs/logcat/summary/mem.txt
local jankfile=//data/local/vendor_logs/logcat/summary/jank.txt
local batteryfile=//data/local/vendor_logs/logcat/summary/batterystats.txt

if [ "x$(getprop persist.sys.ztelog.enable)" != "x1" ]; then
    exit 0
fi

chown system:system /data/local/vendor_logs/logcat/summary

dumpsys usagestats flushall

date > $usagefile
date > $cpufile
date > $jankfile
date > $memfile
date > $batteryfile

cat /data/system/screen_on_time >> $cpufile
show_cpu.sh >> $cpufile
grep "package name" /data/system/packages.xml >> $cpufile

dumpsys graphicsstats >> $jankfile
dumpsys procstats --hours 24 >> $memfile
dumpsys batterystats >> $batteryfile
#dumpsys package|egrep "versionName|Package \[" > /data/local/vendor_logs/logcat/summary/package.list
cat //data/system/packages.xml | grep "package name" | sed 's/">/"\/>/g' > /data/local/vendor_logs/logcat/summary/packages.xml

grep "Displayed" /data/local/vendor_logs/logcat/logcat_am.txt >> $usagefile
echo "" > /data/local/vendor_logs/logcat/logcat_am.txt
chown system:system /data/local/vendor_logs/logcat/summary/*
#dumpsys usagestats clearall
