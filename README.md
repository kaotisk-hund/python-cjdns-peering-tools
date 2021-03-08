# python-cjdns-peering-tools

A small collection of tools for generating and importing peering information through python scripts.

## `appendPeers.py`
It's the script that gets a `cjdroute.conf` and `peers.json` to append IP4 peers to configuration file.

## `gen.sh`
Different ways to generate a `cjdroute.conf` with no comments so we can work with it as JSON in Python.

## `peer_info_generate.py`
Script that creates a user and a password in `authorizedPasswords` and generates `peer_info_generated.json` file.

## `peer_info_generated.json`
This is a generated file by `peer_info_generate.py` which contains the peering information for someone to connect to your node.

You should manually change `0.0.0.0` to your public IP4. #TODO Script for that

## `peers.json`
File with peering information. 

You can use https://github.com/hyperboria/peers to generate `peers.json`
