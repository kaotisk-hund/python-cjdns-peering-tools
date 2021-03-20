# python-cjdns-peering-tools

A small collection of tools for generating and importing peering information through python scripts.

## Requirments
- SystemD (soon openrc compatible as well)
- Python >3.8
- cjdns installed

## Usage
On your terminal, go!

### Clone the repository

Either from:
- github
```
git clone https://github.com/kaotisk-hund/python-cjdns-peering-tools.git
```
- arching-kaos.net
```
git clone https://git.arching-kaos.net/kaotisk/python-cjdns-peering-tools.git
```
- cjdns
```
git clone http://git.kaotisk-hund.com/kaotisk/python-cjdns-peering-tools.git
```
and then cd to it:
```
cd python-cjdns-peering-tools
```

### Install peers from `peers.json` file:

The following script is going to either generate or clean off comments your configuration file,
execute the python script `appendPeers.py`, which will add `peers.json` to your file and install
to default place (/etc/cjdroute.conf). It also restart cjdns for the configuration to be applied.
```
sudo ./gen.sh
```
### Configure new user for peering

Configure a username and a password for a cjdns peer to connect with you. The output file is stored
at `peer_info_generated.json`.
```
sudo ./peer_info_generate.sh
```
You can now open `peer_info_generated.json` and edit the IP before sending to your new peer so it
matches your public one.

## Files

### `appendPeers.py`
It's the script that gets a `cjdroute.conf` and `peers.json` to append IP4 peers to configuration file.

### `gen.sh`
Different ways to generate a `cjdroute.conf` with no comments so we can work with it as JSON in Python.

### `peer_info_generate.py`
Script that creates a user and a password in `authorizedPasswords` and generates `peer_info_generated.json` file.

### `peer_info_generate.sh`
Script that makes a backup of the running ( default /etc/cjdroute.conf ) configuration, executes `peer_info_generate.py`,
pushes the new credentials to your configuration and restart cjdns.

### `peer_info_generated.json`
This is a generated file by `peer_info_generate.py` which contains the peering information for someone to connect to your node.

You should manually change `0.0.0.0` to your public IP4. #TODO Script for that

### `peers.json`
File with peering information. Inside there are two working servers from [Arching Kaos Project](https://arching-kaos.net).

You can use https://github.com/hyperboria/peers to generate `peers.json`
