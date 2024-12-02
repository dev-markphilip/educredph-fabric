#for i in {1..100} ; 
#do 
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.educredph.com --tls --cafile "${PWD}/organizations/ordererOrganizations/educredph.com/orderers/orderer.educredph.com/msp/tlscacerts/tlsca.educredph.com-cert.pem" -C mychannel -n basic --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org1.educredph.com/peers/peer0.org1.educredph.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org2.educredph.com/peers/peer0.org2.educredph.com/tls/ca.crt" -c '{"function":"CreateTestAsset","Args":["asset-d'$(($(date +%s%N)/1000000))'","purple","12","Test User'$i'","1223"]}'
#; done
