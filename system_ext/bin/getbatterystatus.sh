function executesnapshot()
{
echo "####################################################################"  >> $SNAPSHOTPATH
echo "###-------------[$1]---------------###"  >> $SNAPSHOTPATH
echo "####################################################################"  >> $SNAPSHOTPATH
$1 >> $SNAPSHOTPATH
echo ""  >> $SNAPSHOTPATH
}
LOGDIR="/sdcard/"
SNAPSHOTPATH=$LOGDIR"/batterystatus.txt"
echo "=================ADB-PULL-SNAP-SHOT-START========================" > $SNAPSHOTPATH
date  >> $SNAPSHOTPATH
executesnapshot "dumpsys batterystats"
