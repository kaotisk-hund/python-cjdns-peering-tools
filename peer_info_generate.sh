#!/bin/sh
# We run this like this 
echo "Exporting configuration to workfile..."
cat /etc/cjdroute.conf | cjdroute --cleanconf > cjdroute.conf
echo "Backup existing configuration..."
cp /etc/cjdroute.conf /etc/cjdroute.conf-backup
echo "Starting script..."
python peer_info_generate.py
echo "Assuming everything went well ^.^"
echo "Installing new configuration..."
cat cjdroute.conf > /etc/cjdroute.conf
echo "Restarting CJDNS with new peer slots..."
systemctl restart cjdns.service
