#!/system/bin/sh
if [ "x$(getprop persist.sys.ztelog.enable)" != "x1" ]; then
    exit 0
fi
local open=`getprop init.svc.openspeciallog`
if [ "$open" = "running" ] ; then
    dumpsys window -d enable all
    dumpsys activity --dync-log enable all
    dumpsys activity log x on
fi
local close=`getprop init.svc.closespeciallog`
if [ "$close" = "running" ] ; then
    dumpsys window -d disable all
    dumpsys activity --dync-log disable all
    dumpsys activity log x off
fi
