#!/bin/bash
#run-con.sh

./run-yu.sh 100
sleep 20
./run-yu.sh 200
sleep 20
./run-yu.sh 400
sleep 20
./run-yu.sh 500
sleep 20
./run-yu.sh 600
sleep 20
./run-yu.sh 800
sleep 20
./run-yu.sh 1000
sleep 20
./run-yu.sh 1200
sleep 20
./run-yu.sh 1500
sleep 20


cp README_YU.md /home/yu/Res/README_YU.md
# mv /home/yu/Res /home/yu/Res-container-random-perf-v1
# mv /home/yu/Res /home/yu/Res-container-random-latency-v1
