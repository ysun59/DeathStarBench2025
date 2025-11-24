#!/bin/bash
# run-yu.sh
echo "thread: 20, connection: 60, R: $1"
DEST="container_t_20_c_60_R_$1"
mkdir -p /home/yu/Res/$DEST

echo "===================================="

cd ..
cp test-boids/docker-compose-composeCore-4.yml .
sudo docker compose -f docker-compose-composeCore-4.yml up -d

sleep 5
echo "===================================="
python3 scripts/write_movie_info.py -c datasets/tmdb/casts.json -m datasets/tmdb/movies.json --server_address "http://127.0.0.1:8080" && scripts/register_users.sh && scripts/register_movies.sh

echo "===================================="
sleep 20

# enable BOIDS
sudo ../enable-boids-by-compose.py docker-compose-composeCore-4.yml
echo "===================================="
sleep 60
echo "wrk's current affinity list: 0,1"
taskset -c 0,1 ../wrk2/wrk -D exp -t 20 -c 60 -d 60 --timeout 10 -L -s ./wrk2/scripts/media-microservices/compose-review.lua http://localhost:8080/wrk2-api/review/compose -R $1 > "/home/yu/Res/${DEST}/wrk.txt" &

WRK=$!
#sleep 1.  #warmup
mpstat -P ALL 1 > "/home/yu/Res/${DEST}/cpu_perf.txt" &
iostat -x -k 1 > "/home/yu/Res/${DEST}/perf.txt" &
# ./test-boids/runPerf.sh $DEST &
./test-boids/runSchedstat.sh $DEST &
./test-boids/runSchedDebug.sh $DEST &
./test-boids/runInterrupts.sh $DEST &
wait $WRK
killall iostat mpstat



sudo docker compose -f docker-compose-composeCore-4.yml down --volumes

cat "/home/yu/Res/${DEST}/wrk.txt"


sudo sh -c 'sync; echo 3 > /proc/sys/vm/drop_caches'
# verify remove the cache
# grep -E '^(Cached|Buffers):' /proc/meminfo
