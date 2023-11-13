#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y

sudo apt-get install hostapd dnsmasq apache2 -y

sudo service network-manager stop

sudo echo 1 > /proc/sys/net/ipv4/ip_forward
sudo iptables --flush
sudo iptables --table nat --flush
sudo iptables --delete-chain
sudo iptables --table nat --delete-chain
sudo iptables -P FORWARD ACCEPT

sudo fuser -k 53/tcp
sudo fuser -k 53/tcp
sudo fuser -k 53/tcp

sudo dnsmasq -C ./config/dnsmasq.conf
sudo hostapd ./config/hostapd.conf -B

sudo service apache2 start
sudo mv ./config/000-default.conf /etc/apache2/sites-enabled/000-default.conf
sudo mv ./captive-portal/index.html /var/www/html/index.html
sudo service apache2 restart