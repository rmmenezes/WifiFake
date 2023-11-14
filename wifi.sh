#!/bin/bash

#############################################################################
echo "Welcome to the Wi-Fi Fake (Hotspot)"

ifconfig -a

read -p "Enter the name of your Wi-Fi interface: " wifi_interface

sed -i "s/interface=wlan1/interface=$wifi_interface/" ./config/dnsmasq.conf
sed -i "s/interface=wlan1/interface=$wifi_interface/" ./config/hostapd.conf
##############################################################################

sudo apt-get update -y

sudo apt-get install hostapd dnsmasq apache2 iptables php -y

sudo echo 1 > /proc/sys/net/ipv4/ip_forward
sudo iptables --flush
sudo iptables --table nat --flush
sudo iptables --delete-chain
sudo iptables --table nat --delete-chain
sudo iptables -P FORWARD ACCEPT

ifconfig -a
read -p "Enter the name of your interface with Internet: " interface_internet

sudo iptables -t nat -A POSTROUTING -o $interface_internet -j MASQUERADE
sudo iptables -A FORWARD -i $interface_internet -o $wifi_interface -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i $wifi_interface -o $interface_internet -j ACCEPT

sudo fuser -k 53/tcp
sudo fuser -k 53/tcp
sudo fuser -k 53/tcp

sudo dnsmasq -C ./config/dnsmasq.conf
sudo hostapd ./config/hostapd.conf -B

sudo ifconfig $wifi_interface 10.0.0.1 netmask 255.255.255.0

sudo systemctl start apache2.service
sudo a2enmod rewrite
sudo cp ./config/000-default.conf /etc/apache2/sites-enabled/000-default.conf
sudo cp ./captive-portal/index.html /var/www/html/index.html
sudo systemctl restart apache2.service
