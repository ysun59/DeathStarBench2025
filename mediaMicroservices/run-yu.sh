#!/bin/bash
# run-yu.sh

docker compose up -d
python3 scripts/write_movie_info.py -c datasets/tmdb/casts.json -m datasets/tmdb/movies.json --server_address "http://127.0.0.1:8080" && scripts/register_users.sh && scripts/register_movies.sh
../wrk2/wrk -D exp -t 4 -c 6 -d 20  --timeout 5 -L -s ./wrk2/scripts/media-microservices/compose-review.lua http://localhost:8080/wrk2-api/review/compose -R 200
docker compose down --volumes

../wrk2/wrk -D exp -t 30 -c 300 -d 30  --timeout 5 -L -s ./wrk2/scripts/media-microservices/compose-review.lua http://localhost:8080/wrk2-api/review/compose -R 200
