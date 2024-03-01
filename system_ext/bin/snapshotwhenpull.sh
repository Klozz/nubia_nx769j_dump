function executesnapshot()
{
echo "####################################################################"  >> $SNAPSHOTPATH
echo "###-------------[$1]---------------###"  >> $SNAPSHOTPATH
echo "####################################################################"  >> $SNAPSHOTPATH
$1 >> $SNAPSHOTPATH 
echo ""  >> $SNAPSHOTPATH
}
LOGDIR="/data/local/vendor_logs/"
cp /data/system/app_run_info $LOGDIR/logcat/app_run_info.txt
SNAPSHOTPATH=$LOGDIR"/snapshotwhenpull.txt"
echo "=================ADB-PULL-SNAP-SHOT-START========================" > $SNAPSHOTPATH
date  >> $SNAPSHOTPATH
executesnapshot "getprop"
executesnapshot "ps -eT"
executesnapshot "dumpsys batterystats"
executesnapshot "dumpsys SurfaceFlinger"
executesnapshot "dumpsys sensorservice"
executesnapshot "dmesg"
executesnapshot "dumpsys activity"
executesnapshot "dumpsys window"
executesnapshot "dumpsys deviceidle"
executesnapshot "dumpsys device_policy"
executesnapshot "dumpsys appops"
executesnapshot "dumpsys display"
executesnapshot "dumpsys input"
executesnapshot "dumpsys jobscheduler"
executesnapshot "dumpsys notification"
executesnapshot "dumpsys meminfo"
executesnapshot "dumpsys procstats"
executesnapshot "dumpsys package packages"


