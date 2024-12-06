#!/bin/bash

# Declare an associative array
declare -A ports

# Add key-value pairs to the array
ports["org1"]="7054"
ports["org2"]="8054"

USERNAME="$1"
SECRET="$2"
ORGANIZATION="$3"
# Extract the part before the first dot
ORG=$(echo "$ORGANIZATION" | cut -d '.' -f 1)

# echo $USERNAME $SECRET $ORG
export PATH=${PWD}/../bin:$PATH

export FABRIC_CFG_PATH=$PWD/../config/

# # Environment variables for Org1

# export CORE_PEER_TLS_ENABLED=true
# export CORE_PEER_LOCALMSPID="Org1MSP"
# export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org1.educredph.com/peers/peer0.org1.educredph.com/tls/ca.crt
# export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.educredph.com/users/Admin@org1.educredph.com/msp
# export CORE_PEER_ADDRESS=localhost:7051
# echo $PWD

export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/${ORG}.educredph.com/

fabric-ca-client register --caname ca-${ORG} --id.name ${USERNAME} --id.secret ${SECRET} --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/${ORG}/tls-cert.pem

fabric-ca-client enroll -u https://${USERNAME}:${SECRET}@localhost:${ports[${ORG}]} --caname ca-${ORG} -M ${PWD}/organizations/peerOrganizations/${ORG}.educredph.com/users/${USERNAME}@${ORG}.educredph.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/${ORG}/tls-cert.pem

cp ${PWD}/organizations/peerOrganizations/${ORG}.educredph.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/${ORG}.educredph.com/users/${USERNAME}@${ORG}.educredph.com/msp/
