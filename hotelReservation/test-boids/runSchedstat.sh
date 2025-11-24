#runSchedstat.sh
#!/bin/bash

for ((i=1;i<=60;i++));
do
    cat /proc/schedstat >> "/home/yu/Res/$1/schedstat.txt"
    echo >> "/home/yu/Res/$1/schedstat.txt"

    sleep 1
done
