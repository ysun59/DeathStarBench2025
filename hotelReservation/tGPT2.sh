pid=$(docker inspect --format '{{.State.Pid}}' socialnetwork-social-graph-mongodb-1)

sudo strace -f -p $pid -e futex,epoll_wait,clock_nanosleep -ttT -o /tmp/t &
sleep 6; sudo pkill -INT -f "strace -f -p $pid"
tail -n 30 /tmp/t   # futex/epoll_wait 多＝锁/网络等待


# sudo strace -f -p $pid -e futex,epoll_wait,clock_nanosleep -ttT -o /tmp/t &
# sleep 6; sudo pkill -INT -f "strace -f -p $pid"
# tail -n 30 /tmp/t   # futex/epoll_wait 多＝锁/网络等待
