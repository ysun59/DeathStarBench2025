#!/bin/bash
# run-yu.sh

set -eu  # 缺参或出错立即退出（-u: 未设置变量报错）
: "${2:?usage: $0 <arg1> <arg2>}"  # 没有 $2 就报错并退出

echo "thread: 20, connection: 60, R: $1, wrk choose: $2"
DEST="container_t_20_c_60_composePosts_R_$1"
DEST2="container_t_20_c_60_readHomeTimeline_R_$1"
DEST3="container_t_20_c_60_readUserTimeline_R_$1"
mkdir -p /home/yu/Res/$DEST
mkdir -p /home/yu/Res/$DEST2
mkdir -p /home/yu/Res/$DEST3

echo "===================================="
# let 24 containers, each set to different cores, from core 0-32, 34-52

cd ..

if [[ $2 -eq 1 ]];then
    echo "up choose 1"
    cp test-oddEvenCore/docker-1-composePosts.yml .
    sudo docker compose -f docker-1-composePosts.yml up -d
elif [[ $2 -eq 2 ]];then
    echo "up choose 2"
    cp test-oddEvenCore/docker-2-readHomeTimelines.yml .
    sudo docker compose -f docker-2-readHomeTimelines.yml up -d
elif [[ $2 -eq 3 ]];then
    echo "up choose 3"
    cp test-oddEvenCore/docker-3-readUserTimelines.yml .
    sudo docker compose -f docker-3-readUserTimelines.yml up -d
else
    echo "mistake wrk input $2, only support 1, 2, 3"
fi

echo "===================================="
sleep 5
python3 scripts/init_social_graph.py --graph=socfb-Reed98

echo "===================================="
# Compose posts  1+8 5500, 1+6 6000, 2+6 5000
sleep 30

if [[ $2 -eq 1 ]];then
    echo "wrk choose 1"
    echo "wrk's current affinity list: 61, 63"
    taskset -c 61,63 ../wrk2/wrk -D exp -t 20 -c 60 -d 60 --timeout 5 -L -s ./wrk2/scripts/social-network/compose-post.lua http://localhost:8080/wrk2-api/post/compose -R $1 > "/home/yu/Res/${DEST}/wrk.txt" &
elif [[ $2 -eq 2 && $1 -ge 1600 ]]; then
    echo "wrk choose 2 and >= 1600"
    echo "wrk's current affinity list: 63, wrk is 1600"
    taskset -c 63 ../wrk2/wrk -D exp -t 20 -c 60 -d 60 --timeout 5 -L -s ./wrk2/scripts/social-network/compose-post.lua http://localhost:8080/wrk2-api/post/compose -R 1600 > "/home/yu/Res/${DEST}/wrk.txt" &
elif [[ $2 -eq 2 ]];then
    echo "wrk choose 2"
    echo "wrk's current affinity list: 63"
    taskset -c 63 ../wrk2/wrk -D exp -t 20 -c 60 -d 60 --timeout 5 -L -s ./wrk2/scripts/social-network/compose-post.lua http://localhost:8080/wrk2-api/post/compose -R $1 > "/home/yu/Res/${DEST}/wrk.txt" &
elif [[ $2 -eq 3 ]];then
    echo "wrk choose 3"
    echo "wrk's current affinity list: 63"
    taskset -c 61,63 ../wrk2/wrk -D exp -t 20 -c 60 -d 60 --timeout 5 -L -s ./wrk2/scripts/social-network/compose-post.lua http://localhost:8080/wrk2-api/post/compose -R $1 > "/home/yu/Res/${DEST}/wrk.txt" &
else
    echo "mistake wrk input $2, only support 1, 2, 3"
fi



WRK=$!
#sleep 1.  #warmup
mpstat -P ALL 1 > "/home/yu/Res/${DEST}/cpu_perf.txt" &
iostat -x -k 1 > "/home/yu/Res/${DEST}/perf.txt" &
# ./test-oddEvenCore/runPerf.sh $DEST &
./test-oddEvenCore/runSchedstat.sh $DEST &
./test-oddEvenCore/runSchedDebug.sh $DEST &
./test-oddEvenCore/runInterrupts.sh $DEST &
wait $WRK
killall iostat mpstat
cat "/home/yu/Res/${DEST}/wrk.txt"

echo "===================================="
# Read home timelines25000 2+8 2100, 1+8 1000, 1+6 1500
# socialnetwork-post-storage-service-1
# socialnetwork-nginx-thrift-1
sleep 35

if [[ $2 -eq 1 ]];then
    echo "wrk choose 1"
    echo "wrk's current affinity list: 61, 63"
    taskset -c 61,63 ../wrk2/wrk -D exp -t 20 -c 60 -d 60 --timeout 5 -L -s ./wrk2/scripts/social-network/read-home-timeline.lua http://localhost:8080/wrk2-api/home-timeline/read -R $1 > "/home/yu/Res/${DEST2}/wrk.txt" &
elif [[ $2 -eq 2 ]];then
    echo "wrk choose 2"
    echo "wrk's current affinity list: 63"
    taskset -c 63 ../wrk2/wrk -D exp -t 20 -c 60 -d 60 --timeout 5 -L -s ./wrk2/scripts/social-network/read-home-timeline.lua http://localhost:8080/wrk2-api/home-timeline/read -R $1 > "/home/yu/Res/${DEST2}/wrk.txt" &
elif [[ $2 -eq 3 ]];then
    echo "wrk choose 3"
    echo "wrk's current affinity list: 63"
    taskset -c 61,63 ../wrk2/wrk -D exp -t 20 -c 60 -d 60 --timeout 5 -L -s ./wrk2/scripts/social-network/read-home-timeline.lua http://localhost:8080/wrk2-api/home-timeline/read -R $1 > "/home/yu/Res/${DEST2}/wrk.txt" &
else
    echo "mistake wrk input $2, only support 1, 2, 3"
fi

WRK=$!
#sleep 1.  #warmup
mpstat -P ALL 1 > "/home/yu/Res/${DEST2}/cpu_perf.txt" &
iostat -x -k 1 > "/home/yu/Res/${DEST2}/perf.txt" &
# ./test-oddEvenCore/runPerf.sh $DEST2 &
./test-oddEvenCore/runSchedstat.sh $DEST2 &
./test-oddEvenCore/runSchedDebug.sh $DEST2 &
./test-oddEvenCore/runInterrupts.sh $DEST2 &
wait $WRK
killall iostat mpstat
cat "/home/yu/Res/${DEST2}/wrk.txt"

echo "===================================="
# Read user timelines
# 2+8 1420, 1+8 700, 1+6 700
sleep 35

if [[ $2 -eq 1 ]];then
    echo "wrk choose 1"
    echo "wrk's current affinity list: 61, 63"
    taskset -c 61,63 ../wrk2/wrk -D exp -t 20 -c 60 -d 60 --timeout 5 -L -s ./wrk2/scripts/social-network/read-user-timeline.lua http://localhost:8080/wrk2-api/user-timeline/read -R $1 > "/home/yu/Res/${DEST3}/wrk.txt" &
elif [[ $2 -eq 2 ]];then
    echo "wrk choose 2"
    echo "wrk's current affinity list: 63"
    taskset -c 63 ../wrk2/wrk -D exp -t 20 -c 60 -d 60 --timeout 5 -L -s ./wrk2/scripts/social-network/read-user-timeline.lua http://localhost:8080/wrk2-api/user-timeline/read -R $1 > "/home/yu/Res/${DEST3}/wrk.txt" &
elif [[ $2 -eq 3 ]];then
    echo "wrk choose 3"
    echo "wrk's current affinity list: 63"
    taskset -c 61,63 ../wrk2/wrk -D exp -t 20 -c 60 -d 60 --timeout 5 -L -s ./wrk2/scripts/social-network/read-user-timeline.lua http://localhost:8080/wrk2-api/user-timeline/read -R $1 > "/home/yu/Res/${DEST3}/wrk.txt" &
else
    echo "mistake wrk input $2, only support 1, 2, 3"
fi

WRK=$!
#sleep 1.  #warmup
mpstat -P ALL 1 > "/home/yu/Res/${DEST3}/cpu_perf.txt" &
iostat -x -k 1 > "/home/yu/Res/${DEST3}/perf.txt" &
# ./test-oddEvenCore/runPerf.sh $DEST3 &
./test-oddEvenCore/runSchedstat.sh $DEST3 &
./test-oddEvenCore/runSchedDebug.sh $DEST3 &
./test-oddEvenCore/runInterrupts.sh $DEST3 &
wait $WRK
killall iostat mpstat
cat "/home/yu/Res/${DEST3}/wrk.txt"





if [[ $2 -eq 1 ]];then
    echo "down choose 1"
    sudo docker compose -f docker-1-composePosts.yml down --volumes
elif [[ $2 -eq 2 ]];then
    echo "down choose 2"
    sudo docker compose -f docker-2-readHomeTimelines.yml down --volumes
elif [[ $2 -eq 3 ]];then
    echo "down choose 3"
    sudo docker compose -f docker-3-readUserTimelines.yml down --volumes
else
    echo "mistake wrk input $2, only support 1, 2, 3"
fi



sudo sh -c 'sync; echo 3 > /proc/sys/vm/drop_caches'
# verify remove the cache
# grep -E '^(Cached|Buffers):' /proc/meminfo