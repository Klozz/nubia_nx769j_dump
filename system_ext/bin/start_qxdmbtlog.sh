#!/system/bin/sh
# Copyright (c) 2016, ZTE . All rights reserved.
#History:
#when       who         what, where, why
#--------   ----        ---------------------------------------------------
#2016-9-2  xumei         start bluetooth offline qxdm log
##########################################


##set for QXDM logs and use diag_mdlog
setprop persist.service.bdroid.soclog true
setprop enablesnooplog true
setprop enablebtsoclog true
setprop persist.service.bdroid.snooplog true

#normally start bluetooth offline qxdm log
#/system/bin/diag_mdlog -b -c -f /etc/Diag.cfg -o /sdcard/sd_logs/ -s 100&
#/system/bin/diag_mdlog -b -c&
