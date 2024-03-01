#!/system/bin/sh
ipaddr=`getprop sys.diag_socket_log.ip`
target=`getprop ro.board.platform`
if [[ "$target" == "kona" ]]; then
diag_socket_log -a $ipaddr -c 2
else
diag_socket_log -a $ipaddr
fi
