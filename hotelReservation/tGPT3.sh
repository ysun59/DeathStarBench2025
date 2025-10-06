pid=$(docker inspect --format '{{.State.Pid}}' socialnetwork-social-graph-mongodb-1)

ps -L -p $pid -o state= | sort | uniq -c
# 大概率 S(睡眠)/I 或者 少量 R；配合 strace 的 futex/epoll_wait，基本坐实“非CPU型等待”
