#!/bin/bash

set -e

#set firecracker's pid's all the threadID to core, setCore vmName coreNum
#usage example: setCore hotel-reserv-frontend 3
function setCore(){
  PID=`ps aux | grep /tmp/firecracker | grep -v 'grep' | grep $1 | awk {'print $2'}`
	echo "$1 PID is: $PID"

  ps -T -p $PID --ppid $PID

	for loop in $(ps -T -p $PID --ppid $PID | awk {'print $2'} | awk 'NR != 1')
    do echo $loop
       taskset -pc $2 $loop
	done
    echo " "
}

# set to 13, 13, 13, rest->15, 17, 19
function setCoreTwo(){
  PID=`ps aux | grep /tmp/firecracker | grep -v 'grep' | grep $1 | awk {'print $2'}`
	echo "$1 PID is: $PID"

  ps -T -p $PID --ppid $PID

  let firstCore=${2%%,*}
  let lastCore=${2##*,}
  echo "firstCore is: $firstCore"
  echo "lastCore is: $lastCore"

  taskset -pc $firstCore $(ps -T -p $PID --ppid $PID | awk {'print $2'} | awk 'NR==2')
  taskset -pc $firstCore $(ps -T -p $PID --ppid $PID | awk {'print $2'} | awk 'NR==3')
  taskset -pc $firstCore $(ps -T -p $PID --ppid $PID | awk {'print $2'} | awk 'NR==4')

  firstCore=$((firstCore + 2))
  echo "firstCore is: $firstCore"
  
	for loop in $(ps -T -p $PID --ppid $PID | awk {'print $2'} | awk 'NR > 4')
    do echo $loop
       taskset -pc "$firstCore-$lastCore:2" $loop
	done
    echo " "
}

# cpuset to core 35,35,35,rest->36-52
function setCoreMoreContig(){
  PID=`ps aux | grep /tmp/firecracker | grep -v 'grep' | grep $1 | awk {'print $2'}`
	echo "$1 PID is: $PID"

  ps -T -p $PID --ppid $PID

  let firstCore=${2%%,*}
  let lastCore=${2##*,}
  echo "firstCore is: $firstCore"
  echo "lastCore is: $lastCore"

  taskset -pc $firstCore $(ps -T -p $PID --ppid $PID | awk {'print $2'} | awk 'NR==2')
  taskset -pc $firstCore $(ps -T -p $PID --ppid $PID | awk {'print $2'} | awk 'NR==3')
  taskset -pc $firstCore $(ps -T -p $PID --ppid $PID | awk {'print $2'} | awk 'NR==4')

  firstCore=$((firstCore + 1))
  echo "firstCore is: $firstCore"
  
	for loop in $(ps -T -p $PID --ppid $PID | awk {'print $2'} | awk 'NR > 4')
    do echo $loop
       taskset -pc "$firstCore-$lastCore" $loop
	done
    echo " "
}


setCore "user-timeline-redis" "0"
setCore "social-graph-service" "2"
setCore "social-graph-redis" "4"
setCore "media-service" "6"
setCore "post-storage-memcached" "8"
setCore "url-shorten-memcached" "10"
setCore "media-memcached" "12"
setCore "social-graph-mongodb" "14"
setCore "user-mongodb" "16"
setCore "media-mongodb" "18"
setCore "media-frontend" "20"
setCore "user-service" "22"
setCore "unique-id-service" "24"

setCoreTwo "post-storage-mongodb" "26,28"
setCoreTwo "url-shorten-service" "32,34"
setCoreTwo "user-memcached" "36,38,40"

setCoreTwo "user-timeline-service" "42,44,46" # 4
setCoreTwo "user-mention-service" "48,50,52"
setCoreTwo "home-timeline-service" "54,56"
setCore "jaeger-agent" "62"
setCoreTwo "url-shorten-mongodb" "55,57"
setCoreTwo "home-timeline-redis" "58,60"  # 给多了没用
setCoreTwo "text-service" "39,41,43,45,47" # 7

setCore "post-storage-service" "59" #不见htop
setCoreTwo "nginx-thrift" "31,33,35" #need more 55//only 31

setCoreTwo "user-timeline-mongodb" "49,51,53"
setCoreTwo "compose-post-service" "1,3,5,7,9,11,13,15,17,19,21,23,25,27,29" # 1



###################container############################
# setCoreTwo "user-timeline-service" "32,34"
# setCoreTwo "user-mention-service" "36,38"
# setCoreTwo "home-timeline-service" "40,42"
# setCoreTwo "jaeger-agent" "44,46"
# setCoreTwo "url-shorten-mongodb" "48,50"
# setCoreTwo "home-timeline-redis" "52,54,56,58"
# setCoreTwo "text-service" "33,35,37,39"

# setCore "post-storage-service" "60"
# setCoreTwo "nginx-thrift" "41,43,45,47,49,51"

# setCoreTwo "user-timeline-mongodb" "17,19,21,23,25,27,29,31"
# setCoreTwo "compose-post-service" "1,3,5,7,9,11,13,15"

#################firecracker##########################
# setCoreTwo "post-storage-mongodb" "2,4"
# setCore "url-shorten-service" "6,8"
# setCoreTwo "user-memcached" "58,60,62"

# setCoreTwo "user-timeline-service" "32,34,36,38"
# setCoreTwo "user-mention-service" "40,42,44"
# setCoreTwo "home-timeline-service" "46,48"
# setCore "jaeger-agent" "57"
# setCoreTwo "url-shorten-mongodb" "50,52"
# setCoreTwo "home-timeline-redis" "54,56"
# setCoreTwo "text-service" "33,35,37,39,41,43,45"

# setCore "post-storage-service" "59" #不见htop
# setCore "nginx-thrift" "31" #need more 55

# setCoreTwo "user-timeline-mongodb" "47,49,51"
# setCoreTwo "compose-post-service" "1,3,5,7,9,11,13,15,17,19,21,23,25,27,29"











