echo "from txread"

export PATH=${PWD}/../bin:$PATH

export FABRIC_CFG_PATH=$PWD/../config/

# Environment variables for Org1

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org1.educredph.com/peers/peer0.org1.educredph.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.educredph.com/users/Admin@org1.educredph.com/msp
export CORE_PEER_ADDRESS=localhost:7051


echo $CORE_PEER_LOCALMSPID;


peer chaincode query -C mychannel -n basic -c '{"Args":["queryByTxID", "ee8d1feb72701beddfcbcf6ea089578f59316f65ba27fe80495c01c1c6e1ab0f"]}'

