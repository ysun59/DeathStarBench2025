# Social Network
## Set core
Each container is restricted to run on only one CPU socket, either cores 0–31 or cores 32–63

Total 27 containers, let containers, each set to different cores

set wrk to core 61,63

stop all MAAS-related services using `sudo snap stop maas maas-test-db`

Core 62,53,55,57,59 are empty

## VMs - Corresponding cores

* socialnetwork-user-timeline-redis-1 \ —----------- core 0
* socialnetwork-post-storage-mongodb-1 \ ----------- core 2
* socialnetwork-social-graph-service-1 \ ----------- core 4
* socialnetwork-url-shorten-service-1 \ ------------ core 6
* socialnetwork-user-memcached-1 \ ----------—------ core 8

* socialnetwork-social-graph-redis-1 \ —------------ core 10
* socialnetwork-media-service-1 \ ------------------ core 12

* socialnetwork-post-storage-memcached-1 \ --—------ core 14
* socialnetwork-url-shorten-memcached-1 \ -—-------- core 16
* socialnetwork-media-memcached-1 \ -—-------------- core 18
* socialnetwork-social-graph-mongodb-1 \ -—--------- core 20
* socialnetwork-user-mongodb-1 \ -—----------------- core 22
* socialnetwork-media-mongodb-1 \ -—---------------- core 24
* socialnetwork-media-frontend-1 \ --—-------------- core 26
* socialnetwork-user-service-1 \ ------------------- core 28
* socialnetwork-unique-id-service-1 \ -------------- core 30

* socialnetwork-user-timeline-service-1 \ ------—--- core 32,34
* socialnetwork-user-mention-service-1 \ ------—---- core 36,38
* socialnetwork-home-timeline-service-1 \ ------—--- core 40,42

* socialnetwork-jaeger-agent-1 \ -—-—--------------- core 44,46
* socialnetwork-url-shorten-mongodb-1 \ ------------ core 48,50




* socialnetwork-home-timeline-redis-1 \ -——-—------- core 52,54,56,58(给多了没用，总是只有某一个core非常高)
* socialnetwork-text-service-1 \ ------------—------ core 33,35,37,39


* socialnetwork-post-storage-service-1 \ ----------- core 60,[62](read home timeline)(Read user timelines要2-3个)一个时候Compose Posts -R最大
* socialnetwork-nginx-thrift-1 \ ------------—------ core 41,43,45,47,49,51,[53,55](read home timeline)



* socialnetwork-user-timeline-mongodb-1 \ ------—--- core 17,19,21,23,25,27,29,31
* socialnetwork-compose-post-service-1 \ ---—------- core 1,3,5,7,9,11,13,15





## Generation Scrpts：
* test-randomCore
* test-oddEvenCore
