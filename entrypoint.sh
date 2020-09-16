#!/bin/sh
set -e

echo ${username} >> /etc/openvpn/auth
echo ${password} >> /etc/openvpn/auth

if [[ ${1} == "random" ]]
then
  server=$(ls /etc/openvpn/ovpn_${protocol} | shuf -n 1)
  echo "Connecting to random server: ${server}"
  exec /usr/sbin/openvpn "/etc/openvpn/ovpn_${protocol}/${server}"
else
  echo "Connecting to ${1}.nordvpn.com.${protocol}"
  exec /usr/sbin/openvpn "/etc/openvpn/ovpn_${protocol}/${1}.nordvpn.com.${protocol}.ovpn"
fi