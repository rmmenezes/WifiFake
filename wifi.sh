#!/bin/bash

sudo apt-get update -y

sudo apt-get install hostapd dnsmasq apache2 iptables -y

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

sudo ifconfig wlan1 10.0.0.1 netmask 255.255.255.0

sudo service apache2 start
sudo cp ./config/000-default.conf /etc/apache2/sites-enabled/000-default.conf
sudo cp ./captive-portal/index.html /var/www/html/index.html
sudo service apache2 restart