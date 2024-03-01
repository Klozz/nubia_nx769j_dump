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

                echo N > /sys/module/lpm_levels/perf/cpu0/wfi/idle_enabled
                echo N > /sys/module/lpm_levels/perf/cpu0/pc/idle_enabled

                echo N > /sys/module/lpm_levels/perf/cpu1/wfi/idle_enabled
                echo N > /sys/module/lpm_levels/perf/cpu1/pc/idle_enabled

                echo N > /sys/module/lpm_levels/perf/cpu2/wfi/idle_enabled
                echo N > /sys/module/lpm_levels/perf/cpu2/pc/idle_enabled

                echo N > /sys/module/lpm_levels/perf/cpu3/wfi/idle_enabled
                echo N > /sys/module/lpm_levels/perf/cpu3/pc/idle_enabled

                #echo $CPU_max
                CPU_max=`cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq`
                echo $CPU_max > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
                echo $CPU_max > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
                echo $CPU_max > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
                echo $CPU_max > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
                ;;
        esac

        case "$soc_id" in
            "294" | "295" | "313" )

                # settings for 8937/8940

                echo N > /sys/module/lpm_levels/system/perf/cpu0/wfi/idle_enabled
                echo N > /sys/module/lpm_levels/system/perf/cpu0/pc/idle_enabled

                echo N > /sys/module/lpm_levels/system/perf/cpu1/wfi/idle_enabled
                echo N > /sys/module/lpm_levels/system/perf/cpu1/pc/idle_enabled

                echo N > /sys/module/lpm_levels/system/perf/cpu2/wfi/idle_enabled
                echo N > /sys/module/lpm_levels/system/perf/cpu2/pc/idle_enabled

                echo N > /sys/module/lpm_levels/system/perf/cpu3/wfi/idle_enabled
                echo N > /sys/module/lpm_levels/system/perf/cpu3/pc/idle_enabled

                echo N > /sys/module/lpm_levels/system/pwr/cpu4/wfi/idle_enabled
                echo N > /sys/module/lpm_levels/system/pwr/cpu4/pc/idle_enabled

                echo N > /sys/module/lpm_levels/system/pwr/cpu5/wfi/idle_enabled
                echo N > /sys/module/lpm_levels/system/pwr/cpu5/pc/idle_enabled

                echo N > /sys/module/lpm_levels/system/pwr/cpu6/wfi/idle_enabled
                echo N > /sys/module/lpm_levels/system/pwr/cpu6/pc/idle_enabled

                echo N > /sys/module/lpm_levels/system/pwr/cpu7/wfi/idle_enabled
                echo N > /sys/module/lpm_levels/system/pwr/cpu7/pc/idle_enabled
                #Turn all the CPUs on
                echo 4 > /sys/devices/system/cpu/cpu0/core_ctl/max_cpus
                echo 4 > /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
                echo 4 > /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
                echo 4 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
                usleep 500000
                #echo $CPU_max
                CPU_max=`cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq`
                echo $CPU_max > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
                echo $CPU_max > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
                echo $CPU_max > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
                echo $CPU_max > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq

                CPU_max=`cat /sys/devices/system/cpu/cpu4/cpufreq/cpuinfo_max_freq`
                echo $CPU_max > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
                echo $CPU_max > /sys/devices/system/cpu/cpu5/cpufreq/scaling_min_freq
                echo $CPU_max > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq
                echo $CPU_max > /sys/devices/system/cpu/cpu7/cpufreq/scaling_min_freq
                ;;

        esac

    ;;
esac

case "$target" in
    "msm8953")

        if [ -f /sys/devices/soc0/soc_id ]; then
            soc_id=`cat /sys/devices/soc0/soc_id`
        else
            soc_id=`cat /sys/devices/system/soc/soc0/id`
        fi

        case "$soc_id" in
            "293" | "304" |"338" )

                # settings for 8953

                echo N > /sys/module/lpm_levels/system/pwr/cpu0/wfi/idle_enabled
                echo N > /sys/module/lpm_levels/system/pwr/cpu0/pc/idle_enabled

                echo N > /sys/module/lpm_levels/system/pwr/cpu1/wfi/idle_enabled
                echo N > /sys/module/lpm_levels/system/pwr/cpu1/pc/idle_enabled

                echo N > /sys/module/lpm_levels/system/pwr/cpu2/wfi/idle_enabled
                echo N > /sys/module/lpm_levels/system/pwr/cpu2/pc/idle_enabled

                echo N > /sys/module/lpm_levels/system/pwr/cpu3/wfi/idle_enabled
                echo N > /sys/module/lpm_levels/system/pwr/cpu3/pc/idle_enabled

                echo N > /sys/module/lpm_levels/system/perf/cpu4/wfi/idle_enabled
                echo N > /sys/module/lpm_levels/system/perf/cpu4/pc/idle_enabled

                echo N > /sys/module/lpm_levels/system/perf/cpu5/wfi/idle_enabled
                echo N > /sys/module/lpm_levels/system/perf/cpu5/pc/idle_enabled

                echo N > /sys/module/lpm_levels/system/perf/cpu6/wfi/idle_enabled
                echo N > /sys/module/lpm_levels/system/perf/cpu6/pc/idle_enabled

                echo N > /sys/module/lpm_levels/system/perf/cpu7/wfi/idle_enabled
                echo N > /sys/module/lpm_levels/system/perf/cpu7/pc/idle_enabled
                #echo $CPU_max
                CPU_max=`cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq`
                echo $CPU_max > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
                echo $CPU_max > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
                echo $CPU_max > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
                echo $CPU_max > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq

                CPU_max=`cat /sys/devices/system/cpu/cpu4/cpufreq/cpuinfo_max_freq`
                echo $CPU_max > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
                echo $CPU_max > /sys/devices/system/cpu/cpu5/cpufreq/scaling_min_freq
                echo $CPU_max > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq
                echo $CPU_max > /sys/devices/system/cpu/cpu7/cpufreq/scaling_min_freq
                ;;

        esac

    ;;
esac

case "$target" in
    "msm8996")

        if [ -f /sys/devices/soc0/soc_id ]; then
            soc_id=`cat /sys/devices/soc0/soc_id`
        else
            soc_id=`cat /sys/devices/system/soc/soc0/id`
        fi

        case "$soc_id" in
            "246" )

                # settings for 8996

                echo N > /sys/module/lpm_levels/system/pwr/cpu0/wfi/idle_enabled
                echo N > /sys/module/lpm_levels/system/pwr/cpu0/fpc/idle_enabled
                echo N > /sys/module/lpm_levels/system/pwr/cpu0/fpc-def/idle_enabled

                echo N > /sys/module/lpm_levels/system/perf/cpu1/fpc/idle_enabled
                echo N > /sys/module/lpm_levels/system/perf/cpu1/wfi/idle_enabled
                echo N > /sys/module/lpm_levels/system/perf/cpu1/fpc-def/idle_enabled

                #echo $CPU_max
                CPU_max=`cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq`
                echo $CPU_max > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
                echo $CPU_max > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq

                CPU_max=`cat /sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_max_freq`
                echo $CPU_max > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
                echo $CPU_max > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
                ;;

        esac

    ;;
esac

case "$target" in
    "sdm660")

        if [ -f /sys/devices/soc0/soc_id ]; then
            soc_id=`cat /sys/devices/soc0/soc_id`
        else
            soc_id=`cat /sys/devices/system/soc/soc0/id`
        fi

        case "$soc_id" in
            "345" )

                # settings for SDM636

                echo N > /sys/module/lpm_levels/system/pwr/cpu0/pc/idle_enabled
                echo N > /sys/module/lpm_levels/system/pwr/cpu0/ret/idle_enabled
                echo N > /sys/module/lpm_levels/system/pwr/cpu0/wfi/idle_enabled

                echo N > /sys/module/lpm_levels/system/pwr/cpu1/pc/idle_enabled
                echo N > /sys/module/lpm_levels/system/pwr/cpu1/ret/idle_enabled
                echo N > /sys/module/lpm_levels/system/pwr/cpu1/wfi/idle_enabled

                echo N > /sys/module/lpm_levels/system/pwr/cpu2/pc/idle_enabled
                echo N > /sys/module/lpm_levels/system/pwr/cpu2/ret/idle_enabled
                echo N > /sys/module/lpm_levels/system/pwr/cpu2/wfi/idle_enabled

                echo N > /sys/module/lpm_levels/system/pwr/cpu3/pc/idle_enabled
                echo N > /sys/module/lpm_levels/system/pwr/cpu3/ret/idle_enabled
                echo N > /sys/module/lpm_levels/system/pwr/cpu3/wfi/idle_enabled

                echo N > /sys/module/lpm_levels/system/perf/cpu4/pc/idle_enabled
                echo N > /sys/module/lpm_levels/system/perf/cpu4/ret/idle_enabled
                echo N > /sys/module/lpm_levels/system/perf/cpu4/wfi/idle_enabled

                echo N > /sys/module/lpm_levels/system/perf/cpu5/pc/idle_enabled
                echo N > /sys/module/lpm_levels/system/perf/cpu5/ret/idle_enabled
                echo N > /sys/module/lpm_levels/system/perf/cpu5/wfi/idle_enabled

                echo N > /sys/module/lpm_levels/system/perf/cpu6/pc/idle_enabled
                echo N > /sys/module/lpm_levels/system/perf/cpu6/ret/idle_enabled
                echo N > /sys/module/lpm_levels/system/perf/cpu6/wfi/idle_enabled

                echo N > /sys/module/lpm_levels/system/perf/cpu7/pc/idle_enabled
                echo N > /sys/module/lpm_levels/system/perf/cpu7/ret/idle_enabled
                echo N > /sys/module/lpm_levels/system/perf/cpu7/wfi/idle_enabled

                #echo $CPU_max
                CPU_max=`cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq`
                echo $CPU_max > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
                echo $CPU_max > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
                echo $CPU_max > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
                echo $CPU_max > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq

                CPU_max=`cat /sys/devices/system/cpu/cpu4/cpufreq/cpuinfo_max_freq`
                echo $CPU_max > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
                echo $CPU_max > /sys/devices/system/cpu/cpu5/cpufreq/scaling_min_freq
                echo $CPU_max > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq
                echo $CPU_max > /sys/devices/system/cpu/cpu7/cpufreq/scaling_min_freq
                ;;

        esac

    ;;
esac

case "$target" in
    "sdm845")
        # settings for SDM845
        echo Y > /sys/module/lpm_levels/parameters/sleep_disabled
        echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu5/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor
    ;;
esac

case "$target" in
    "msmnile")
        # settings for SM8150
        echo Y > /sys/module/lpm_levels/parameters/sleep_disabled
        echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu5/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor
    ;;
esac

case "$target" in
    "lahaina")
        # settings for SM8350
        echo Y > /sys/module/lpm_levels/parameters/sleep_disabled
        echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu5/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor
    ;;
esac

case "$target" in
    "bengal")
        # settings for SM6115
        echo Y > /sys/module/lpm_levels/parameters/sleep_disabled
        echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu5/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor
    ;;
esac

case "$target" in
    "kona")
        # settings for SM8250
        echo Y > /sys/module/lpm_levels/parameters/sleep_disabled
        echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu5/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor
    ;;
esac

case "$target" in
    "taro")
        # settings for SM8450
        echo 1 > /sys/devices/system/cpu/qcom_lpm/parameters/sleep_disabled
        echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu5/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
        echo performance > /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor
    ;;
esac

