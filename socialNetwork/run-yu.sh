#!/bin/bash
# run-yu.sh

sudo docker compose -f docker-compose-composeCore-4.yml up -d

python3 scripts/init_social_graph.py --graph=socfb-Reed98
python3 scripts/init_social_graph.py --ip=10.10.11.51 --graph=socfb-Reed98


# Compose Posts 1+8 5500, 1+6 6000, 2+6 5000
taskset -c 61,63 ../wrk2/wrk -D exp -t 20 -c 60 -d 60 --timeout 5 -L -s ./wrk2/scripts/social-network/compose-post.lua http://localhost:8080/wrk2-api/post/compose -R 5500
taskset -c 61,63 ../wrk2/wrk -D exp -t 20 -c 60 -d 60 --timeout 5 -L -s ./wrk2/scripts/social-network/compose-post.lua http://10.10.11.51:8080/wrk2-api/post/compose -R 1500

# Read home timelines/25000 2+8 2100, 1+8 1000, 1+6 1500
# socialnetwork-post-storage-service-1
# socialnetwork-nginx-thrift-1
taskset -c 61,63 ../wrk2/wrk -D exp -t 20 -c 60 -d 60 --timeout 5 -L -s ./wrk2/scripts/social-network/read-home-timeline.lua http://localhost:8080/wrk2-api/home-timeline/read -R 1500
taskset -c 61,63 ../wrk2/wrk -D exp -t 20 -c 60 -d 60 --timeout 5 -L -s ./wrk2/scripts/social-network/read-home-timeline.lua http://10.10.11.51:8080/wrk2-api/home-timeline/read -R 1000

# Read user timelines 2+8 1420, 1+8 700, 1+6 700
taskset -c 61,63 ../wrk2/wrk -D exp -t 20 -c 60 -d 60 --timeout 5 -L -s ./wrk2/scripts/social-network/read-user-timeline.lua http://localhost:8080/wrk2-api/user-timeline/read -R 700
taskset -c 61,63 ../wrk2/wrk -D exp -t 4 -c 6 -d 20 --timeout 5 -L -s ./wrk2/scripts/social-network/read-user-timeline.lua http://10.10.11.51:8080/wrk2-api/user-timeline/read -R 500

sudo docker compose -f docker-compose-composeCore-4.yml down --volumes

sudo sh -c 'sync; echo 3 > /proc/sys/vm/drop_caches'
