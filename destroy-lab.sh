echo -n "[*] Press enter to delete the lab : "
read x
echo "[+] Stoping containers"
docker stop pivot-container-1 pivot-container-2 pivot-container-3 pivot-container-4 >/dev/null
echo "[+] Deleting containers"
docker rm pivot-container-1 pivot-container-2 pivot-container-3 pivot-container-4 >/dev/null
echo "[+] Removing networks"
docker network rm network-1 network-2 network-3 >/dev/null
echo "[+] Done"
