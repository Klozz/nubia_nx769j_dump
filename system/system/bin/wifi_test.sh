#!/system/bin/sh
insmod /vendor/lib/modules/qca_cld3_kiwi_v2.ko con_mode=5
sleep 1
toybox ifconfig wlan0 | toybox grep "wlan0"
if [ $? -eq 0 ]; then
    echo true
else
    echo false
fi
sleep 1
rmmod qca_cld3_kiwi_v2
