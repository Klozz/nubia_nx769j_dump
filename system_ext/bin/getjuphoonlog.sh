#!/system/bin/sh
home=$(pwd)
out_log_path=/sdcard/sd_logs/wetest_juphoon_log.tar.gz
juphoon_log_dir=/sdcard/Android/data/com.ztercs.service/files/JuphoonService/
cd ${juphoon_log_dir} && tar zcvf ${out_log_path} log
sleep 2
cd "$home" || return
