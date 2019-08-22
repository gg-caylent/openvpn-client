#!/bin/sh
sleep 1

# Create tun device
mkdir -p /dev/net
[[ -c /dev/net/tun ]] || mknod -m 0666 /dev/net/tun c 10 200


# Replace all values with their secrets
sleep 3
envsubst < /vpn/login.data.tmpl > /vpn/login.data
envsubst < /vpn/config.ovpn.tmpl > /vpn/config.ovpn


# Launch the openvpn process
sleep 3
exec sg vpn -c "openvpn --config /vpn/config.ovpn"
