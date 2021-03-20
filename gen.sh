#!/bin/bash

# Nowadays :) <- we keep this in order to learn something valueable, soon to be deleted!
#cjdroute --genconf | sed -n '/^\/\*.*\*\//!p' | sed -n '/ \/\/.*/!p' | sed 's|/\*|\n&|g;s|*/|&\n|g' | sed '/\/\*/,/*\//d' > cjdroute.conf

# Futuristic way B-)
echo "gen.sh - Peering tools"
echo "Checking for existing configuration (WARNING!! All comments will be stripped)"
if [ -f /etc/cjdroute.conf ]; then
	cat /etc/cjdroute.conf > /etc/cjdroute.conf-back && cat /etc/cjdroute.conf | cjdroute --cleanconf > cjdroute.conf;
else
	cjdroute --genconf | cjdroute --cleanconf > cjdroute.conf;
fi
python appendPeers.py
cat cjdroute.conf > /etc/cjdroute.conf
echo "Restart cjdns to get the new configuration up..."
systemctl restart cjdns

echo "Suppose it's done!"
