#!/usr/bin/env python3
import sys
import subprocess
import os

containers = {}
def get_names_and_cpus(file):
    f = open(file, "r")
    name = ""
    cpus = 0
    for line in f:
        if("container_name: " in line):
            name = line.split("container_name: ")[1].strip("'").rstrip("\n").rstrip("'")
        if("cpus: " in line):
            cpus = line.split("cpus: ")[1].strip(" ").rstrip()
            containers[name] = cpus
    f.close()
    print(containers)

def set_boids():
    try:
        result = subprocess.run(["docker", "ps", "--no-trunc"], capture_output=True, text=True, check=True)

        print(result.stdout)
        for line in result.stdout.split("\n"):
            if("PORTS" in line or len(line) < 5):
                continue
            row = line.rstrip().split()
            name = row[-1]
            id = row[0]

            if(name in containers):
                boids = containers[name]
                print(f"setting {name} --> {id}: boids={boids}")
                with open(f"/sys/fs/cgroup/system.slice/docker-{id}.scope/cpu.boids", "w") as f:
                    f.write(boids)

    except subprocess.CalledProcessError as e:
        print(f"Failed to set boids: {e}")

if __name__ == "__main__":
    if(len(sys.argv) < 2):
        print(f"Usage: {sys.argv[0]} docker_compose.yml")
        exit(1)

    get_names_and_cpus(sys.argv[1])
    set_boids()
