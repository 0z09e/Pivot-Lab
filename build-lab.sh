#!/bin/bash
echo "[+] Installing necessary files"
sudo apt update
sudo apt install docker.io
echo "[+] Building the sudo docker image : debian-pivot"
sudo docker build -t debian-pivot .
echo "[+] Creating Network"
sudo docker network create network-1 --internal --subnet=172.10.0.0/24 >/dev/null
echo "[+] Network-1 : 172.10.0.0/24"
sudo docker network create network-2 --internal --subnet=172.11.0.0/24 >/dev/null
echo "[+] Network-2 : 172.11.0.0/24" 
sudo docker network create network-3 --internal --subnet=172.12.0.0/24 >/dev/null
echo "[+] Network-3 : 172.12.0.0/24" 
echo "[+] Building sudo dockers"
sudo docker run -d -it --name=pivot-container-1 -p 9090:80  -p 2222:22 --restart always -h target1 debian-pivot /entrypoint.sh >/dev/null
echo "[+] Container 1 : IP - $(sudo docker exec -it pivot-container-1 ifconfig eth0 | grep inet | awk '{print $2}')"
sudo docker run -d -it --name=pivot-container-2 --network=network-1 --restart always -h target2 debian-pivot /entrypoint.sh >/dev/null
echo "[+] Container 2 : IP - $(sudo docker exec -it pivot-container-2 ifconfig eth0 | grep inet | awk '{print $2}')"
sudo docker run -d -it --name=pivot-container-3 --network=network-2 --restart always -h target3 debian-pivot /entrypoint.sh >/dev/null
echo "[+] Container 3 : IP - $(sudo docker exec -it pivot-container-3 ifconfig eth0 | grep inet | awk '{print $2}')"
sudo docker run -d -it --name=pivot-container-4 --network=network-3 --restart always -h target4 debian-pivot /entrypoint.sh >/dev/null
echo "[+] Container 4 : IP - $(sudo docker exec -it pivot-container-4 ifconfig eth0 | grep inet | awk '{print $2}')"
echo "[+] Building the connection"
sudo docker network connect network-1 pivot-container-1
echo "[+] pivot-container-1 and pivot-container-2 are connected"
sudo docker network connect network-2 pivot-container-2
echo "[+] pivot-container-2 and pivot-container-3 are connected"
sudo docker network connect network-3 pivot-container-3
echo "[+] pivot-container-2 and pivot-container-3 are connected"
echo "[+] Your target is at http://0.0.0.0
:9090. Good luck and happy pivoting" 
