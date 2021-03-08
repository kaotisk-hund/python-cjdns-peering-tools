import json
# function to add to JSON
def write_json(data, filename='cjdroute.conf'):
    with open(filename,'w') as f:
        json.dump(data, f, indent=4)
with open('cjdroute.conf') as json_file:
    data = json.load(json_file)
    temp = data['interfaces']
    temp2 = temp['UDPInterface']
    temp3 = temp2[0]
    temp4 = temp3['connectTo']
    with open('peers.json') as peers:
        peers = json.load(peers)
        temp4.update(peers)

write_json(data)
