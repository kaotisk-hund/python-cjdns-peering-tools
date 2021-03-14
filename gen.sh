#!/bin/sh
# Previous implementation
#cjdroute --genconf > cjdroute.json
#grep -v '^\s*//\|^\s*$' cjdroute.json > cjdroute-nc.json
#perl -p0e 's!/\*.*?\*/!!sg' cjdroute-nc.json > cjdroute.conf

# Nowadays :)
#cjdroute --genconf | sed -n '/^\/\*.*\*\//!p' | sed -n '/ \/\/.*/!p' | sed 's|/\*|\n&|g;s|*/|&\n|g' | sed '/\/\*/,/*\//d' > cjdroute.conf

# Futuristic way B-)
sudo dnf install cjdns-tools -y
sudo systemctl start cjdns
sudo systemctl stop cjdns
cjdroute --genconf | cjdroute --cleanconf > cjdroute.conf
python appendPeers.py
sudo cat cjdroute.conf > /etc/cjdroute.conf
sudo systemctl enable cjdns
sudo systemctl start cjdns
