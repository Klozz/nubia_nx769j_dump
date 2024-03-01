#!/system/bin/sh
cell=`getprop ro.vendor.feature.for_zte_cell`


/system/bin/iotop -m 16 -d 30 -P -a -s cpu -D -n 240
#for dual system
if [ "$cell" = "true" ]; then
	while true
	do
		sleep 30
		real_pid=""
		all_pids=`pidof iotop`
		pids=($all_pids)
		for i in ${all_pids[@]}
		do
		ppid=`ps -p $i | awk 'NR==2{print $3}'`
			if [ "$ppid" == "1" ];then
				real_pid="$i"
				break;
			fi
		done

		echo "real_pid:$real_pid"
		if [ "$real_pid" == "" ]; then
		echo "will start iotop process"
		/system/bin/iotop -m 16 -d 30 -P -a -s cpu -D -n 240
		fi
	done
#for one android system
else

	while true
	do
	sleep 30
	pidof iotop
	if [ $? -eq 1 ]; then
	/system/bin/iotop -m 16 -d 30 -P -a -s cpu -D -n 240
	fi
	done
fi

