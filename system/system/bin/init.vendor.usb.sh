#!/system/bin/sh
# Copyright (c) 2012, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
#     * Neither the name of The Linux Foundation nor the names of its
#       contributors may be used to endorse or promote products derived
#      from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
# ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

#
# Get global values
#
mode=`getprop ro.bootmode`
debuggable=`getprop ro.debuggable`
default_usb_config=`getprop persist.sys.usb.config`
current_usb_config=`getprop sys.usb.config`
target=`getprop ro.board.platform`

# soc_ids for 8937
if [ -f /sys/devices/soc0/soc_id ]; then
    soc_id=`cat /sys/devices/soc0/soc_id`
else
    soc_id=`cat /sys/devices/system/soc/soc0/id`
fi
echo $soc_id
#

#
# Do init rmnet and serial transports
#
configfs=`getprop sys.usb.configfs`
if [[ "$configfs" == "0" ]]; then
    case "$target" in
        "msm8996")
            echo "qti,bam2bam_ipa" > /sys/class/android_usb/android0/f_rmnet/rmnet_transports_init
            echo "char_bridge,tty,tty" > /sys/class/android_usb/android0/f_serial/transports_init
            ;;
        "msm8909")
            echo "qti,bam" > /sys/class/android_usb/android0/f_rmnet/rmnet_transports_init
            echo "smd,tty,smd" > /sys/class/android_usb/android0/f_serial/transports_init
            ;;
        "msm8937")
            case "$soc_id" in
                "313" | "320")
                    echo "qti,bam2bam_ipa" > /sys/class/android_usb/android0/f_rmnet/rmnet_transports_init
                    echo "smd,tty,smd" > /sys/class/android_usb/android0/f_serial/transports_init
                    ;;
                *)
                    echo "qti,bam" > /sys/class/android_usb/android0/f_rmnet/rmnet_transports_init
                    echo "smd,tty,smd" > /sys/class/android_usb/android0/f_serial/transports_init
                    ;;
            esac
            ;;
        "msm8952" | "msm8953")
            echo "qti,bam2bam_ipa" > /sys/class/android_usb/android0/f_rmnet/rmnet_transports_init
            echo "smd,tty,smd" > /sys/class/android_usb/android0/f_serial/transports_init
            ;;
         *);;
    esac
fi

#
# Check ESOC for external MDM
#
if [ -d /sys/bus/esoc/devices ]; then
for f in /sys/bus/esoc/devices/*; do
    if [ -d $f ]; then
    if [ `grep -e "^MDM" -e "^SDX" $f/esoc_name` ]; then
            esoc_link=`cat $f/esoc_link`
            break
        fi
    fi
done
fi

#
# Default config for userdebug
#
if [ "$esoc_link" != "" ]; then
    userdebug_config=diag,diag_mdm,adb
else
    userdebug_config=diag,adb
fi

#
# Process adb according to eng/user build
#
case "$debuggable" in
    "1")
        case "$mode" in
            "ffbm"*)
                echo "ftm mode, do nothing."
            ;;
            *)
                result=$(echo $default_usb_config | grep "adb")
                if [[ "$result" != "" ]]; then
                    echo "default_usb_config already has adb"
                    usb_config=$default_usb_config
                else
                    case "$default_usb_config" in
                        "charging")
                            usb_config=$userdebug_config
                        ;;
                        *)
                            if [[ "$default_usb_config" != "" ]]; then
                                usb_config=$default_usb_config,adb
                            else
                                usb_config=$userdebug_config
                            fi
                        ;;
                    esac
                fi

                case "$target" in
                     "lahaina")
                     if [[ "$default_usb_config" == "" ]]; then
                        usb_config=diag,qdss,adb
                     fi
                    ;;
                esac

                setprop persist.sys.usb.config $usb_config
                result=$(echo $current_usb_config | grep "adb")
                if [[ "$result" != "" ]]; then
                    echo "current_usb_config already has adb"
                else
                    setprop sys.usb.config $usb_config
                fi
            ;;
        esac
    ;;
    *);;
esac

#

#
# Enable ADB for tradefed
#
adbTradefed=`getprop ro.adbtradefed`
case "adbTradefed" in
    "1")
        setprop persist.sys.usb.config diag,adb
    ;;
    *);;
esac

#
# Enable NoZtePrefix
#
noZtePrefix=`getprop persist.sys.usb.noZtePrefix`
case "noZtePrefix" in
    "1")
        echo 1 > /sys/class/android_usb/android0/noZtePrefix
    ;;
    *);;
esac
