# cgroup v2
cat /sys/fs/cgroup/cpu.max
cat /sys/fs/cgroup/cpu.stat   # 关注 nr_throttled / throttled_usec 是否在涨
# cgroup v1（如适用）
cat /sys/fs/cgroup/cpu/cpu.cfs_quota_us
cat /sys/fs/cgroup/cpu/cpu.stat
