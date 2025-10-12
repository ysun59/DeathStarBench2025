# DeathStarBench
Here's the **ready-to-use scripts** provided by **Yu**.

The scripts are divided into two categories:
- **cpuset mode** — benchmarks are pinned to specific CPU cores to achieve the **maximum throughput**.
- **random (cpus) mode** — benchmarks run with only the `--cpus` option set (no CPU affinity).The number of `--cpus` assigned corresponds to the number of cores used in the **cpuset** configuration.

## hotelReservation

### Pinned (CPU-set) mode
```bash
cd hotelReservation/test-oddEvenCore
./run-yu.sh 1000
# 1000 indicates request/second (RPS)
```

### Default (random-core) mode
```bash
cd hotelReservation/test-randomCore
./run-yu.sh 1000
# 1000 indicates request/second (RPS)
```
For the exact container-to-core mapping, see[hotelReservation/test-oddEvenCore/README_YU.md](hotelReservation/test-oddEvenCore/README_YU.md)

## mediaMicroservices

### Pinned (CPU-set) mode
```bash
cd mediaMicroservices/test-oddEvenCore
./run-yu.sh 1000
# 1000 indicates request/second (RPS)
```

### Default (random-core) mode
```bash
cd mediaMicroservices/test-randomCore
./run-yu.sh 1000
# 1000 indicates request/second (RPS)
```
For the exact container-to-core mapping, see[mediaMicroservices/test-oddEvenCore/README_YU.md](mediaMicroservices/test-oddEvenCore/README_YU.md)
## socialNetwork

### Pinned (CPU-set) mode
```bash
cd socialNetwork/test-oddEvenCore

# Case 1: cpuset optimized for Compose Posts
./run-yu.sh 1000 1

# Case 2: cpuset optimized for Read Home Timelines
./run-yu.sh 1000 2

# Case 3: cpuset optimized for Read User Timelines
./run-yu-3.sh 1000
# 1000 indicates request/second (RPS)
```

### Default (random-core) mode
```bash
cd socialNetwork/test-randomCore

# Case 1: random (cpus) for Compose Posts
./run-yu.sh 1000 1

# Case 2: random (cpus) for Read Home Timelines
./run-yu.sh 1000 2

# Case 3: random (cpus) for Read User Timelines
./run-yu-3.sh 1000
# 1000 indicates request/second (RPS)
```

### Reference: container-to-core mapping
#### Compose Posts
See[socialNetwork/test-oddEvenCore/README_YU_1.md](socialNetwork/test-oddEvenCore/README_YU_1.md)

#### Read Home Timelines
See[socialNetwork/test-oddEvenCore/README_YU_2.md](socialNetwork/test-oddEvenCore/README_YU_2.md)


#### Read User Timelines
See[socialNetwork/test-oddEvenCore/README_YU_3.md](socialNetwork/test-oddEvenCore/README_YU_3.md)