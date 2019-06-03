# openvpn-updown

These up/down scripts complement the openvpn client by passing the push DNS options to resolvconf, enabling automatic DNS server reconfiguration.

The two push options supported currently are `dhcp-option DNS` and `dhcp-option DOMAIN`. Multiple DNS options can be added but only one DOMAIN option is supported.

Add these scripts to your client .ovpn config files by copying the up/down.sh scripts into the same directory and adding:
```
script-security 2
up up.sh
down down.sh
```

The scripts require bash and resolvconf.

