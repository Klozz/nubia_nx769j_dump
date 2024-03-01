#!/vendor/bin/sh

# This script is used to imitate an usb offline event for testing standby current of handset.
#
# How to use this file:
#
# adb push switch_usb_mode.sh /data/
# adb shell
# cd /data/
# chmod 777 switch_usb_mode.sh
# ./switch_usb_mode.sh

echo 0 > /sys/devices/virtual/charger/test/set_usb_online