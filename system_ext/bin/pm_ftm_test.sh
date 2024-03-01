#!/system/bin/sh
#this .sh is used to test current while devices enter LPM in FTM

#how to run this .sh
#adb push ftmlpm.sh /data/
#adb shell
#cd /data
#chmod 777 ftmlpm.sh
#./ftmlpm.sh
CPU_max=`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq`
#echo $CPU_max
#cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo $CPU_max > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
#Wcat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 1 > /sys/module/lpm_levels/parameters/sleep_disabled



