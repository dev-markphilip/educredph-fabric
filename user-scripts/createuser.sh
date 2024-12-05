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

export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/org1.educredph.com/

fabric-ca-client register --caname ca-org1 --id.name user2 --id.secret user2pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem

fabric-ca-client enroll -u https://user2:user2pw@localhost:7054 --caname ca-org1 -M ${PWD}/organizations/peerOrganizations/org1.educredph.com/users/User2@org1.educredph.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/org1/tls-cert.pem

cp ${PWD}/organizations/peerOrganizations/org1.educredph.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org1.educredph.com/users/User2@org1.educredph.com/msp/
