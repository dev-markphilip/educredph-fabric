./network.sh down

./network.sh up createChannel -c mychannel -ca

./network.sh deployCC -ccn basic -ccp ../asset-transfer-basic/educredph-chaincode/ -ccl typescript

multitime -n 1000 -s 0 bash insertcredentials.sh


