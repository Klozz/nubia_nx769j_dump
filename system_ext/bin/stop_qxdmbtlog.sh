#!/system/bin/sh
# Copyright (c) 2016, ZTE . All rights reserved.
#History:
#when       who         what, where, why
#--------   ----        ---------------------------------------------------
#2016-9-2  xumei         stop bluetooth offline qxdm log
##########################################


##set for QXDM logs/use diag_mdlog
#/system/bin/diag_mdlog -k

setprop persist.service.bdroid.soclog false
setprop enablesnooplog false
setprop enablebtsoclog false
setprop persist.service.bdroid.snooplog false
