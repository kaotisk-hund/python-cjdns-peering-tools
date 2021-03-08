import json
import random
import string
# function to add to JSON
def write_json(data, filename='cjdroute.conf'):
    with open(filename,'w') as f:
        json.dump(data, f, indent=4)

# function to output peer_info
def write_info(data2, filename='peer_info_generated.json'):
    with open(filename,'w') as g:
        json.dump(data2, g, indent=4)

# function to generate passwords
def get_random_string(length):
    # choose from all lowercase letter
    letters = string.ascii_lowercase
    return ''.join(random.choice(letters) for i in range(length))
#    print("Random string of length", length, "is:", result_str)

with open('cjdroute.conf') as json_file:
    data = json.load(json_file)
# Store publicKey
    publicKey = data['publicKey']
# Store aythorized passwords
    authorizedPasswords = data['authorizedPasswords']
# Ask for a username
    username = input("Enter username:")
# Create a password
    password = get_random_string(24)
# Get block ready
    adduser = {"password":password,"user":username}
# Update JSON
    authorizedPasswords.append(adduser)
# Print dict
    print(json.dumps(data))
# Do write please
    write_json(data)
# Prepare the variables for peer_info_generation
    temp = data['interfaces']
    temp2 = temp['UDPInterface']
    temp3 = temp2[0]
    public_ip4 = temp3['bind']
    peerOutput = {public_ip4: {"login":username,"password":password,"publicKey":publicKey}}
#    data2.append(peerOutput)
#    with open('peers.json') as peers:
#        peers = json.load(peers)
#        temp4.update(peers)
    write_info(peerOutput)
