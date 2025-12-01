echo "balance interval"
sudo sysctl -w kernel.boids_balance_cooldown=0
sudo sysctl -w kernel.boids_balance_min_threshold=25
sudo sysctl -w kernel.boids_migration_cooldown=0
sudo sysctl -a | grep boids
