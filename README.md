# docker-wireguard

Wireguard in Docker

```
vi docker-compose.yml
```
```
version: "3.3"
services:
  wireguard:
    container_name: wireguard
    image: ghcr.io/antyung88/wireguard:main
    restart: unless-stopped
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
    volumes:
      - ./config:/config
      - ./wireguard:/etc/wireguard
    ports:
      - 51820:51820/udp
    sysctls:
      - net.ipv4.conf.all.src_valid_mark=1
```
```
mkdir config
mkdir wireguard
```

```
cd wireguard
```
```
docker run --rm ghcr.io/antyung88/wireguard:main genkeys
```
Save down Output.

# Configuration

```
cd config
```

An example for the server's configuration can be found below.

```
[Interface]
PrivateKey = <server-private-key>
Address = 10.10.10.1/24
ListenPort = 51820
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE; iptables -A FORWARD -o %i -j ACCEPT
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE; iptables -D FORWARD -o %i -j ACCEPT

[Peer]
AllowedIPs = 10.10.10.2/32
PublicKey = <client-public-key>
```

An example for a client's configuration can be found below.

```
[Interface]
PrivateKey = <client-private-key>
Address = 10.10.10.2/24
DNS = <dns-server-of-choice>

[Peer]
PublicKey = <server-public-key>
AllowedIPs = 0.0.0.0/0, ::/0
Endpoint = <server-hostname-or-ip>:51820
```
