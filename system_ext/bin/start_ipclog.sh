#!/system/bin/sh
# Copyright (c) 2009, ZTE . All rights reserved.
#History:
#when       who         what, where, why
#--------   ----        ---------------------------------------------------
#2022-6-17 10310975   capture ipc log
##########################################
chmod 775 /data/local/vendor_logs/kernel/
rm -rf /data/local/vendor_logs/kernel/qup_uart_rx.txt
rm -rf /data/local/vendor_logs/kernel/qup_uart_tx.txt
rm -rf /data/local/vendor_logs/kernel/qup_uart_misc.txt
rm -rf /data/local/vendor_logs/kernel/qup_uart_pwr.txt
rm -rf /data/local/vendor_logs/kernel/qup_uart_irqstatus.txt

mount -t debugfs none /sys/kernel/debug

echo "Start to cat ipc log ..."
BOARD=$(getprop ro.board.platform)

function save_ipc_log()
{
    echo "save_ipc_log"
    if [ "$BOARD" = "taro" ]; then
        while true
        do
        cat /sys/kernel/debug/ipc_logging/894000.qcom,qup_uart_rx/log_cont >> /data/local/vendor_logs/kernel/qup_uart_rx.txt &
        sleep 5
        done

    elif [ "$BOARD" = "lahaina" ]; then
        while true
        do
        cat /sys/kernel/debug/ipc_logging/890000.qcom,qup_uart_rx/log_cont >> /data/local/vendor_logs/kernel/qup_uart_rx.txt &
        sleep 5
        done

    elif [ "$BOARD" = "kona" ]; then
        while true
        do
        cat /sys/kernel/debug/ipc_logging/998000.qcom,qup_uart_rx/log_cont >> /data/local/vendor_logs/kernel/qup_uart_rx.txt &
        sleep 5
        done

    elif [ "$BOARD" = "kalama" ]; then
        while true
        do
        cat /sys/kernel/debug/ipc_logging/898000.qcom,qup_uart_rx/log_cont >> /data/local/vendor_logs/kernel/qup_uart_rx.txt
        sleep 5
        done
    else
        echo "something is wrong with platform"

    fi
}

function save_ipc_log2()
{
    if [ "$BOARD" = "taro" ]; then
        while true
        do
        cat /sys/kernel/debug/ipc_logging/894000.qcom,qup_uart_tx/log_cont >> /data/local/vendor_logs/kernel/qup_uart_tx.txt &
        sleep 5
        done

    elif [ "$BOARD" = "lahaina" ]; then
        while true
        do
        cat /sys/kernel/debug/ipc_logging/890000.qcom,qup_uart_tx/log_cont >> /data/local/vendor_logs/kernel/qup_uart_tx.txt &
        sleep 5
        done

    elif [ "$BOARD" = "kona" ]; then
        while true
        do
        cat /sys/kernel/debug/ipc_logging/998000.qcom,qup_uart_tx/log_cont >> /data/local/vendor_logs/kernel/qup_uart_tx.txt &
        sleep 5
        done

    elif [ "$BOARD" = "kalama" ]; then
        while true
        do
        cat /sys/kernel/debug/ipc_logging/898000.qcom,qup_uart_tx/log_cont >> /data/local/vendor_logs/kernel/qup_uart_tx.txt
        sleep 5
        done
    else
        echo "something is wrong with platform"

    fi
}

function save_ipc_log3()
{
    if [ "$BOARD" = "taro" ]; then
        while true
        do
        cat /sys/kernel/debug/ipc_logging/894000.qcom,qup_uart_misc/log_cont >> /data/local/vendor_logs/kernel/qup_uart_misc.txt &
        sleep 5
        done

    elif [ "$BOARD" = "lahaina" ]; then
        while true
        do
        cat /sys/kernel/debug/ipc_logging/890000.qcom,qup_uart_misc/log_cont >> /data/local/vendor_logs/kernel/qup_uart_misc.txt &
        sleep 5
        done

    elif [ "$BOARD" = "kona" ]; then
        while true
        do
        cat /sys/kernel/debug/ipc_logging/998000.qcom,qup_uart_misc/log_cont >> /data/local/vendor_logs/kernel/qup_uart_misc.txt &
        sleep 5
        done

    elif [ "$BOARD" = "kalama" ]; then
        while true
        do
        echo "save_ipc_log 3"
        cat /sys/kernel/debug/ipc_logging/898000.qcom,qup_uart_misc/log_cont >> /data/local/vendor_logs/kernel/qup_uart_misc.txt
        sleep 5
        done
    else
        echo "something is wrong with platform"

    fi
}

function save_ipc_log4()
{
    if [ "$BOARD" = "taro" ]; then
        while true
        do
        cat /sys/kernel/debug/ipc_logging/894000.qcom,qup_uart_pwr/log_cont >> /data/local/vendor_logs/kernel/qup_uart_pwr.txt &
        sleep 5
        done

    elif [ "$BOARD" = "lahaina" ]; then
        while true
        do
        cat /sys/kernel/debug/ipc_logging/890000.qcom,qup_uart_pwr/log_cont >> /data/local/vendor_logs/kernel/qup_uart_pwr.txt &
        sleep 5
        done

    elif [ "$BOARD" = "kona" ]; then
        while true
        do
        cat /sys/kernel/debug/ipc_logging/998000.qcom,qup_uart_pwr/log_cont >> /data/local/vendor_logs/kernel/qup_uart_pwr.txt &
        sleep 5
        done

    elif [ "$BOARD" = "kalama" ]; then
        while true
        do
        cat /sys/kernel/debug/ipc_logging/898000.qcom,qup_uart_pwr/log_cont >> /data/local/vendor_logs/kernel/qup_uart_pwr.txt
        sleep 5
        done
    else
        echo "something is wrong with platform"

    fi
}

function save_ipc_log5()
{
    if [ "$BOARD" = "taro" ]; then
        while true
        do
        cat /sys/kernel/debug/ipc_logging/894000.qcom,qup_uart_irqstatus/log_cont >> /data/local/vendor_logs/kernel/qup_uart_irqstatus.txt &
        sleep 5
        done

    elif [ "$BOARD" = "lahaina" ]; then
        while true
        do
        cat /sys/kernel/debug/ipc_logging/890000.qcom,qup_uart_irqstatus/log_cont >> /data/local/vendor_logs/kernel/qup_uart_irqstatus.txt &
        sleep 5
        done

    elif [ "$BOARD" = "kona" ]; then
        while true
        do
        cat /sys/kernel/debug/ipc_logging/998000.qcom,qup_uart_irqstatus/log_cont >> /data/local/vendor_logs/kernel/qup_uart_irqstatus.txt &
        sleep 5
        done

    elif [ "$BOARD" = "kalama" ]; then
        while true
        do
        cat /sys/kernel/debug/ipc_logging/898000.qcom,qup_uart_irqstatus/log_cont >> /data/local/vendor_logs/kernel/qup_uart_irqstatus.txt
        sleep 5
        done
    else
        echo "something is wrong with platform"

    fi
}
function mainloop()
{
}

save_ipc_log &
save_ipc_log2 &
save_ipc_log3 &
save_ipc_log4 &
save_ipc_log5 &

while true
do
    mainloop
done
