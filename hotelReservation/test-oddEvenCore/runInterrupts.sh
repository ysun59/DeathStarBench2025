#runInterrupts.sh
#!/bin/bash

for ((i=1;i<=60;i++));
do
    cat /proc/interrupts >> "/home/yu/Res/$1/interrupts.txt"
    echo >> "/home/yu/Res/$1/interrupts.txt"

    sleep 1
done
