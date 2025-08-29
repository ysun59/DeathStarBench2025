#!/bin/bash


sudo docker compose -f docker-compose-composeCore-4.yml up -d

sleep 5

python3 scripts/init_social_graph.py --graph=socfb-Reed98

sleep 20
taskset -c 61,63 ../wrk2/wrk -D exp -t 20 -c 60 -d 60 --timeout 5 -L -s ./wrk2/scripts/social-network/compose-post.lua http://localhost:8080/wrk2-api/post/compose -R $1

# taskset -c 61,63 ../wrk2/wrk -D exp -t 20 -c 60 -d 60 --timeout 5 -L -s ./wrk2/scripts/social-network/read-home-timeline.lua http://localhost:8080/wrk2-api/home-timeline/read -R 1500

# taskset -c 61,63 ../wrk2/wrk -D exp -t 20 -c 60 -d 60 --timeout 5 -L -s ./wrk2/scripts/social-network/read-user-timeline.lua http://localhost:8080/wrk2-api/user-timeline/read -R 700



sudo docker compose -f docker-compose-composeCore-4.yml down --volumes

sudo sh -c 'sync; echo 3 > /proc/sys/vm/drop_caches'

