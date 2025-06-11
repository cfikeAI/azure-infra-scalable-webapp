#!/bin/bash

echo "=== Disk Mount Check ==="
lsblk | grep sdc1
df -h | grep /mnt/data

echo -e "\n=== NGINX Check ==="
curl localhost | grep -i "<title\|<h1\|portfolio"

echo -e "\n=== Firewall Check ==="
sudo ufw status

echo -e "\n=== Public IP Check ==="
curl -s http://icanhazip.com
