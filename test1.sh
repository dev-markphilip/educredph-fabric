time for i in {1..10} ; do peer chaincode query -C mychannel -n basic -c '{"Args":["GetAllAssets"]}'; done
