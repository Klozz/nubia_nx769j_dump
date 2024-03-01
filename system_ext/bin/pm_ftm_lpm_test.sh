#!/system/bin/sh
#this .sh is used to test current while devices enter LPM in FTM

#how to run this .sh
#adb push ftmlpm.sh /data/
#adb shell
#cd /data
#chmod 777 ftmlpm.sh
#./ftmlpm.sh

platform=`getprop ro.board.platform`
setprop debug.factory.powertest 0
setprop debug.factory.powerkey 0
echo "pm_ftm_lpm_test.sh enter" > /dev/kmsg
target=`getprop ro.board.platform`
if [ -f "/sys/class/backlight/panel0-backlight/brightness" ];then
    if [ x"$1" != "xphone" ] ; then
        echo "pm_ftm_lpm_test.sh single board test" > /dev/kmsg
        dumpsys battery unplug
        if [[ "_$platform" == "_lahaina" ]] || [[ "_$platform" == "_taro" ]] || [[ "_$platform" == "_kalama" ]] || [[ "_$platform" == "_pineapple" ]]; then
            echo 0 > /sys/class/qcom-battery/charging_enabled
        elif [[ "_$platform" == "_bengal" ]]; then
            echo 0 > /sys/class/power_supply/battery/battery_charging_enabled
        else
            echo 0 > /sys/class/power_supply/battery/charging_enabled
        fi
    else
        echo "pm_ftm_lpm_test.sh whole phone test" > /dev/kmsg
    fi
    echo "pm_ftm_lpm_test.sh step1-1 " > /dev/kmsg
    input keyevent POWER
    echo "pm_ftm_lpm_test.sh step1-2" > /dev/kmsg
    setprop debug.factory.powerkey 1
else
    echo "pm_ftm_lpm_test.sh step1-3" > /dev/kmsg
    echo 0 > /sys/class/leds/lcd-backlight/brightness
    echo 4 > /sys/class/graphics/fb0/blank
    echo "pm_ftm_lpm_test.sh step1-4" > /dev/kmsg
fi
echo "pm_ftm_lpm_test.sh step2" > /dev/kmsg
echo mmi > /sys/power/wake_unlock
echo PowerManagerService.Display > /sys/power/wake_unlock
echo PowerManagerService.WakeLocks > /sys/power/wake_unlock
echo "pm_ftm_lpm_test.sh step3" > /dev/kmsg
setprop debug.factory.powertest 1
