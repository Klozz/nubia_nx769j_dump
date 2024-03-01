#!/system/bin/sh
# Copyright (c) 2009, ZTE . All rights reserved.
#History:
#when       who         what, where, why
#--------   ----        ---------------------------------------------------
#2012-08-09 gengxianhu   enable bluetooth ssp debug mode 
##########################################

hcitool cmd 0x06 0x0004 0x01
