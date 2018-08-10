#!/usr/bin/zsh
## Script to output lan speed

interface=$1

received1=$(cat /sys/class/net/wlp0s20u3/statistics/rx_bytes)
transmitted1=$(cat /sys/class/net/wlp0s20u3/statistics/tx_bytes)
sleep 1
received2=$(cat /sys/class/net/wlp0s20u3/statistics/rx_bytes)
transmitted2=$(cat /sys/class/net/wlp0s20u3/statistics/tx_bytes)

received_per_sec=$(bc <<< ($received2-$received1)/1024)
transmitted_per_sec=$(bc <<< ($transmitted2-$transmitted1)/1024)

case "${#received_per_sec}" in
    1) received_per_sec="   $received_per_sec KB/s";;
    2) received_per_sec="  $received_per_sec KB/s";;
    3) received_per_sec=" $received_per_sec KB/s";;
    4) received_per_sec=$(bc <<< "scale=2;$received_per_sec/1024"); received_per_sec=" $received_per_sec MB/s"
esac
case "${#transmitted_per_sec}" in
    1) transmitted_per_sec="   $transmitted_per_sec KB/s";;
    2) transmitted_per_sec="  $transmitted_per_sec KB/s";;
    3) transmitted_per_sec=" $transmitted_per_sec KB/s";;
    4) transmitted_per_sec=$(bc <<< $transmitted_per_sec/1024); transmitted_per_sec="   $transmitted_per_sec MB/s"
esac

echo "$received_per_sec $transmitted_per_sec"
