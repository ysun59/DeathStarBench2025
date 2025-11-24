#runSchedDebug.sh
#!/bin/bash

for ((i=1;i<=60;i++));
do
    sudo cat /sys/kernel/debug/sched/debug >> "/home/yu/Res/${1}/schedDebug.txt"
    # cat /proc/sched_debug >> "/home/yu/Res/${1}/schedDebug.txt"
    echo >> "/home/yu/Res/${1}/schedDebug.txt"

    sleep 1
done
