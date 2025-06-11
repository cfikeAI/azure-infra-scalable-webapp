#!/bin/bash
# Update & install NGINX
apt update -y && apt upgrade -y
apt install nginx -y

# Mount disk (assumes it's always /dev/sdc1)
mkfs.ext4 -F /dev/sdc
mkdir -p /mnt/data
mount /dev/sdc1 /mnt/data
echo '/dev/sdc1 /mnt/data ext4 defaults,nofail 0 2' >> /etc/fstab

# Clone GitHub repo into /mnt/data
apt install git -y
git clone https://github.com/cfikeAI/portfolio_website.git /mnt/data/site

# Replace default nginx site with HTML
rm -rf /var/www/html/*
cp -r /mnt/data/site/* /var/www/html/

# Optional: enable firewall rules
ufw allow OpenSSH
ufw allow 'Nginx Full'
ufw --force enable

# Start nginx (safety)
systemctl enable nginx
systemctl restart nginx
