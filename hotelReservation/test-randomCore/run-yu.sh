#!/bin/bash
# run-yu.sh

echo "thread: 20, connection: 60, R: $1"
DEST="container_t_20_c_60_R_$1"
mkdir -p /home/yu/Res/$DEST

echo "===================================="
# let 24 containers, each set to different cores, from core 0-32, 34-52

cd ..
cp test-randomCore/docker-compose-frontCore-4.yml .
sudo docker compose -f docker-compose-frontCore-4.yml up -d
echo "===================================="
sleep 20
echo "wrk's current affinity list: 63"
taskset -c 63 ../wrk2/wrk -D exp -t 20 -c 60 -d 60 --timeout 5 -L -s ./wrk2/scripts/hotel-reservation/mixed-workload_type_1.lua http://192.168.132.31:5000 -R $1 > "/home/yu/Res/${DEST}/wrk.txt" &

WRK=$!
#sleep 1.  #warmup
mpstat -P ALL 1 > "/home/yu/Res/${DEST}/cpu_perf.txt" &
iostat -x -k 1 > "/home/yu/Res/${DEST}/perf.txt" &
# ./test-randomCore/runPerf.sh $DEST &
./test-randomCore/runSchedstat.sh $DEST &
./test-randomCore/runSchedDebug.sh $DEST &
./test-randomCore/runInterrupts.sh $DEST &
wait $WRK
killall iostat mpstat




docker compose -f docker-compose-frontCore-4.yml down --volumes

cat "/home/yu/Res/${DEST}/wrk.txt"


sudo sh -c 'sync; echo 3 > /proc/sys/vm/drop_caches'
# verify remove the cache
# grep -E '^(Cached|Buffers):' /proc/meminfo