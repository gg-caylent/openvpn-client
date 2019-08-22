# Create tun device
mkdir -p /dev/net
[[ -c /dev/net/tun ]] || mknod -m 0666 /dev/net/tun c 10 200

# Replace all values with their secrets
envsubst < login.data.tmpl > /vpn/login.data
envsubst < config.ovpn.tmpl > /vpn/config.ovpn

# Launch the openvpn process
exec sg vpn -c "openvpn --config /vpn/config.ovpn.tmpl"
