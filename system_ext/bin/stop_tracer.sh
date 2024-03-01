#!/system/bin/sh

#case "$emmc_boot"
#    in "true")
#
#    ;;
#esac
#if [ "x$(getprop persist.sys.ztelog.enable)" != "x1" ]; then
#        exit 0
#fi
################################################################33 0x800000
#add busybox path to system env PATH
PATH=$PATH:/system/vendor/xbin/

atrace --async_stop >/dev/null

