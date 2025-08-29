# Media Microservices
# Set core
Total 33 containers, 32 firecrackers

let 30 firecrackers, each set to different one core, from core 0,2,4,6,8…….30 AND 17, 19, 21

let firecracker media-microservice-compose-review-memcached set to core 23, 25

set social-network-compose-post-service to core 1 or above (basically core 1,3,5-more-15)

set wrk to core 31, or 31, 29

If it is container, the container mediamicroservices-dns-media-1 set to core 11

## VMs - Corresponding cores
* mediamicroservices-review-storage-mongodb \ -—-—----------------—-- core 0
* mediamicroservices-user-review-mongodb \ -—-—----------------—----- core 2
* mediamicroservices-movie-review-mongodb \ -—-—----------------—---- core 4
* mediamicroservices-unique-id-service \ -—-—------------------------ core 6
* mediamicroservices-text-service \ -—-—----------------—------------ core 8
* mediamicroservices-rating-service \ -—-—----------------—---------- core 10
* mediamicroservices-user-service \ -—-—----------------—------------ core 12
* mediamicroservices-review-storage-service \ -—-—------------------- core 14
* mediamicroservices-user-review-service \ -—-—---------------------- core 16
* mediamicroservices-movie-review-service \ -—-—--------------------- core 18

* mediamicroservices-rating-redis \ -—-—----------------—------------ core 20
* mediamicroservices-movie-review-redis \ -—-—----------------—------ core 22
* mediamicroservices-user-review-redis \ -—-—------------------------ core 24

* mediamicroservices-movie-id-memcached \ -—-—----------------—------ core 26 (后加的)
* mediamicroservices-user-memcached \ -—-—-----------------—--------- core 28 (后加的)
* mediamicroservices-review-storage-memcached  -—-—------------------ core 30
* mediamicroservices-cast-info-memcached  -—-—----------------—------ core 32
* mediamicroservices-plot-memcached  -—-—---------—------------------ core 34
* mediamicroservices-movie-info-memcached  -—-—----------------—----- core 36
* mediamicroservices-movie-id-mongodb  -—-—-------------------------- core 38
* mediamicroservices-user-mongodb  -—-—-----------—------------------ core 40
* mediamicroservices-cast-info-mongodb  -—-—------------------------- core 42
* mediamicroservices-plot-mongodb  -—-—----------------—------------- core 44
* mediamicroservices-movie-info-mongodb  -—-—------------------------ core 46
* mediamicroservices-cast-info-service  -—-—------------------------- core 48
* mediamicroservices-plot-service  -—-—----------------—------------- core 50
* mediamicroservices-movie-info-service  -—-—------------------------ core 52

* mediamicroservices-nginx-web-server \ -—-—------—------------------ core 54(没法给多，会崩溃,/core给24， 26能跑28秒左右)

* mediamicroservices-jaeger \ -—-—----------------—------------------ core 13,15（R-800隔一段时间会很多，改成2个了，其实R小的话，不用那么多）
* mediamicroservices-movie-id-service \ -—-—------------------------- core 17,19

* mediamicroservices-compose-review-memcached \ -—-—---------—------- core 21,23,25,27
* mediamicroservices-compose-review-service \ -—-—------------------- core 1, 3, 5, -more- 7

* container mediamicroservices-dns-media-1 -—-—---------------------- core 11

core 26,28,30, 9,11，是空的,container多一个dns-media-1占core 11

## There is little different from set cores
- Container has 33 vms(container mediamicroservices-dns-media-1), firecracker has 32 vms
