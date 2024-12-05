#!/bin/bash

echo "here"
export PATH=${PWD}/../bin:$PATH

export FABRIC_CFG_PATH=$PWD/../config/

# Environment variables for Org1

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org1.educredph.com/peers/peer0.org1.educredph.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.educredph.com/users/Admin@org1.educredph.com/msp
export CORE_PEER_ADDRESS=localhost:7051

CHANNEL_NAME="mychannel"
BLOCK_NUM=6


# Fetch the block
peer channel fetch $BLOCK_NUM block_${BLOCK_NUM}.pb -c $CHANNEL_NAME

# Decode the block
curl -X POST --data-binary @block_${BLOCK_NUM}.pb http://localhost:7059/protolator/decode/common.Block > block_${BLOCK_NUM}.json

# Display transaction details
jq '.data.data[] | .payload' block_${BLOCK_NUM}.json
