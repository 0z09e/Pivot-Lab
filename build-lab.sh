#!/bin/bash
echo "[+] Building the docker image : debian-pivot"
docker build -t debian-pivot .
echo "[+] Creating Network"
docker network create network-1 --internal --subnet=172.10.0.0/24 >/dev/null
echo "[+] Network-1 : 172.10.0.0/24"
docker network create network-2 --internal --subnet=172.11.0.0/24 >/dev/null
echo "[+] Network-2 : 172.11.0.0/24" 
docker network create network-3 --internal --subnet=172.12.0.0/24 >/dev/null
echo "[+] Network-3 : 172.12.0.0/24" 
echo "[+] Building Dockers"
docker run -d -it --name=pivot-container-1 -p 9090:80  -p 1222:22 -h target1 debian-pivot /entrypoint.sh >/dev/null
echo "[+] Container 1 : IP - $(docker exec -it pivot-container-1 ifconfig eth0 | grep inet | awk '{print $2}')"
docker run -d -it --name=pivot-container-2 --network=network-1 -p 2222:22 -h target2 debian-pivot /entrypoint.sh >/dev/null
echo "[+] Container 2 : IP - $(docker exec -it pivot-container-2 ifconfig eth0 | grep inet | awk '{print $2}')"
docker run -d -it --name=pivot-container-3 --network=network-2 -p 3222:22 -h target3 debian-pivot /entrypoint.sh >/dev/null
echo "[+] Container 3 : IP - $(docker exec -it pivot-container-3 ifconfig eth0 | grep inet | awk '{print $2}')"
docker run -d -it --name=pivot-container-4 --network=network-3  -p 4222:22 -h target4 debian-pivot /entrypoint.sh >/dev/null
echo "[+] Container 4 : IP - $(docker exec -it pivot-container-4 ifconfig eth0 | grep inet | awk '{print $2}')"
echo "[+] Building the connection"
docker network connect network-1 pivot-container-1
echo "[+] pivot-container-1 and pivot-container-2 are connected"
docker network connect network-2 pivot-container-2
echo "[+] pivot-container-2 and pivot-container-3 are connected"
docker network connect network-3 pivot-container-3
echo "[+] pivot-container-2 and pivot-container-3 are connected"
echo "[+] Your target is at http://127.0.0.1:9090. Good luck and happy pivoting" 
