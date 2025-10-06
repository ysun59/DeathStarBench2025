#!/bin/bash

#两个方法
#$id is container id
#docker top 
total_threads=0
total_threads_yu=0

for id in $(docker ps -q); do
  pid=$(docker inspect --format '{{.State.Pid}}' $id)
  thread_count=$(ls /proc/$pid/task/ | wc -l)
  #pstree -p 225513 | grep -o '([0-9]\+)' | wc -l
  thread_count_yu=$(pstree -p $pid | grep -o '([0-9]\+)' | wc -l)
  name=$(docker inspect --format '{{.Name}}' $id | cut -c2-)
  # echo "$name ($id): $thread_count threads"
  # echo "pid is $pid"
  echo "$name ($id): $thread_count threads; yu's count is $thread_count_yu"
  total_threads=$((total_threads + thread_count))
  total_threads_yu=$((total_threads_yu + thread_count_yu))
done

echo "--------------------------------"
echo "Total threads across all containers: $total_threads"
echo "Total threads yu across all containers: $total_threads_yu"



################################################################

# #只留一个方法
# #$id is container id
# #docker top 
# total_threads=0

# for id in $(docker ps -q); do
#   pid=$(docker inspect --format '{{.State.Pid}}' $id)
#   thread_count=$(ls /proc/$pid/task/ | wc -l)
#   #pstree -p 225513 | grep -o '([0-9]\+)' | wc -l
#   name=$(docker inspect --format '{{.Name}}' $id | cut -c2-)
#   # echo "$name ($id): $thread_count threads"
#   # echo "pid is $pid"
#   echo "$name ($id): $thread_count threads;"
#   total_threads=$((total_threads + thread_count))
# done

# echo "--------------------------------"
# echo "Total threads across all containers: $total_threads"


# echo ""
# echo ""
################################################################

