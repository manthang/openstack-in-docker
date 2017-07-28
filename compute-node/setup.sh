#!/bin/bash

# System-wide settings
hostnamectl set-hostname $1
timedatectl set-timezone Asia/Ho_Chi_Minh


# Setup NTP client
apt update && apt install -y chrony

mv /etc/chrony/chrony.conf /etc/chrony/chrony.conf.bak

cat > /etc/chrony/chrony.conf <<- EOM
server controller01 iburst
keyfile /etc/chrony/chrony.keys
commandkey 1
driftfile /var/lib/chrony/chrony.drift
log tracking measurements statistics
logdir /var/log/chrony
maxupdateskew 100.0
dumponexit
dumpdir /var/lib/chrony
allow 10.10.10.0/24
logchange 0.5
hwclockfile /etc/adjtime
rtcsync
EOM

service chrony restart

# Setup Compute
apt update && apt install -y software-properties-common
add-apt-repository cloud-archive:ocata -y
apt update && apt install -y python-pymysql nova-compute

# Clean up unused default settings
virsh net-destroy default
virsh net-undefine default
service libvirtd restart
