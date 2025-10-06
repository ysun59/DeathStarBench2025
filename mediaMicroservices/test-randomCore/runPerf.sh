#runPerf.sh
#!/bin/bash

#record data from 25s - 35s
sleep 25

# #test core 1
# perf record -F 99 -C 1 -g -o "/home/yu/Res/$1/perf.data" -- sleep 10
# #test all cores
# perf record -F 99 -a -g -o "/home/yu/Res/$1/perf.data" -- sleep 10

#test cache case A
sudo /home/yu/ubuntu-linux-mainline-6.15/tools/perf/perf stat -e L1-dcache-load-misses,L1-dcache-loads,LLC-load-misses,LLC-loads,LLC-store-misses,LLC-stores,dTLB-load-misses,dTLB-loads,dTLB-store-misses,dTLB-stores,iTLB-load-misses,iTLB-loads,instructions,itlb_misses.stlb_hit,itlb_misses.walk_completed -a -o "/home/yu/Res/$1/perf_stat_cache.txt" -- sleep 10
# sudo /home/yu/ubuntu-linux-mainline-6.15/tools/perf/perf stat -e L1-dcache-load-misses,L1-dcache-loads,LLC-load-misses,LLC-loads,LLC-store-misses,LLC-stores,dTLB-load-misses,dTLB-loads,dTLB-store-misses,dTLB-stores,iTLB-load-misses,iTLB-loads -a -o "/home/yu/Res/$1/perf_stat_cache.txt" -- sleep 10
#test cache case B
sleep 10

sudo /home/yu/ubuntu-linux-mainline-6.15/tools/perf/perf stat -a -o "/home/yu/Res/$1/perf_stat_a.txt" -- sleep 10