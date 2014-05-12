#!/bin/bash
#Usage: softap interface_with_wifi interface_with_internets

#Initial wifi interface configuration
ifconfig $1 up 10.0.0.1 netmask 255.255.255.0
sleep 2
##Start dhcp###
if [ "$(ps -e | grep dhcpd)" == "" ]; then
dhcpd -cf dhcpd.conf $1 &
fi
########
###Enable NAT
iptables --flush
iptables --table nat --flush
iptables --delete-chain
iptables --table nat --delete-chain
iptables --table nat --append POSTROUTING --out-interface $2 -j MASQUERADE
iptables --append FORWARD --in-interface $1 -j ACCEPT

#
sysctl -w net.ipv4.ip_forward=1

#hostapd  hostapd.conf |& awk '{ print "\033[35m", strftime("%m-%d-%Y %H:%M:%S"), "\033[39m", $0 }'
hostapd -t hostapd.conf

killall dhcpd

