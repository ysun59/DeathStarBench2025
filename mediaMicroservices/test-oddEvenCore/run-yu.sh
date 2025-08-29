#!/bin/bash
# run-yu.sh
cd ..
cp test-oddEvenCore/docker-compose-composeCore-4.yml .
sudo docker compose -f docker-compose-composeCore-4.yml up -d

sleep 5
echo "===================================="
python3 scripts/write_movie_info.py -c datasets/tmdb/casts.json -m datasets/tmdb/movies.json --server_address "http://127.0.0.1:8080" && scripts/register_users.sh && scripts/register_movies.sh
python3 scripts/write_movie_info.py -c datasets/tmdb/casts.json -m datasets/tmdb/movies.json --server_address http://10.10.12.65:8080

echo "===================================="
sleep 5

../wrk2/wrk -D exp -t 4 -c 6 -d 20  --timeout 5 -L -s ./wrk2/scripts/media-microservices/compose-review.lua http://localhost:8080/wrk2-api/review/compose -R 200


echo "===================================="














sudo docker compose -f docker-compose-composeCore-4.yml down --volumes

# #recover the docker-compose.yml
# cp docker-compose.yml.bk docker-compose.yml


sync
echo 3 > /proc/sys/vm/drop_caches