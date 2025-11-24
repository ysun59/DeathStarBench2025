#runPerf.sh
#!/bin/bash

#record data from 25s - 35s
sleep 25

# -C 1 means collect the data in core 1, sleep 10 means collect 10s's data.
# sudo /home/yu/ubuntu-linux-mainline-6.15/tools/perf/perf record -F 99 -C 1 -g -o "/home/yu/Res/$1/perfFlameGraph.data" -- sleep 10
# sleep 10

sudo /home/yu/ubuntu-linux-mainline-6.15/tools/perf/perf record -F 99 -a -g -o "/home/yu/Res/$1/perfFlameGraph.data" -- sleep 10