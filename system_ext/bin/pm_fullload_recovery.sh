#!/system/bin/sh
#this .sh is used to test current while devices enter fullload in FTM

#how to run this .sh
#adb push ftmlpm.sh /data/
#adb shell
#cd /data
#chmod 777 ftmlpm.sh
#./ftmlpm.sh

target=`getprop ro.board.platform`

case "$target" in
    "msm8937")

        if [ -f /sys/devices/soc0/soc_id ]; then
            soc_id=`cat /sys/devices/soc0/soc_id`
        else
            soc_id=`cat /sys/devices/system/soc/soc0/id`
        fi

        case "$soc_id" in
            "303" | "307" | "308" | "309" | "320" )

                # settings for 8917 / 8920

                echo Y > /sys/module/lpm_levels/perf/cpu0/wfi/idle_enabled
                echo Y > /sys/module/lpm_levels/perf/cpu0/pc/idle_enabled

                echo Y > /sys/module/lpm_levels/perf/cpu1/wfi/idle_enabled
                echo Y > /sys/module/lpm_levels/perf/cpu1/pc/idle_enabled

                echo Y > /sys/module/lpm_levels/perf/cpu2/wfi/idle_enabled
                echo Y > /sys/module/lpm_levels/perf/cpu2/pc/idle_enabled

                echo Y > /sys/module/lpm_levels/perf/cpu3/wfi/idle_enabled
                echo Y > /sys/module/lpm_levels/perf/cpu3/pc/idle_enabled

                #echo $CPU_min
                CPU_min=`cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq`
                echo $CPU_min > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
                echo $CPU_min > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
                echo $CPU_min > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
                echo $CPU_min > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
                ;;
        esac        
esac

case "$target" in
    "lahaina")
        # settings for SM8350
        echo N > /sys/module/lpm_levels/parameters/sleep_disabled
        echo schedutil > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo schedutil > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
        echo schedutil > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
        echo schedutil > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
        echo schedutil > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
        echo schedutil > /sys/devices/system/cpu/cpu5/cpufreq/scaling_governor
        echo schedutil > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
        echo schedutil > /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor
    ;;
esac

case "$target" in
    "bengal")
        # settings for SM6115
        echo N > /sys/module/lpm_levels/parameters/sleep_disabled
        echo schedutil > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo schedutil > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
        echo schedutil > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
        echo schedutil > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
        echo schedutil > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
        echo schedutil > /sys/devices/system/cpu/cpu5/cpufreq/scaling_governor
        echo schedutil > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
        echo schedutil > /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor
    ;;
esac

case "$target" in
    "taro")
        # settings for SM8350
        echo N > /sys/module/lpm_levels/parameters/sleep_disabled
        echo schedutil > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo schedutil > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
        echo schedutil > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
        echo schedutil > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
        echo schedutil > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
        echo schedutil > /sys/devices/system/cpu/cpu5/cpufreq/scaling_governor
        echo schedutil > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
        echo schedutil > /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor
    ;;
esac

