#!/bin/bash
peer chaincode query -C mychannel -n basic -c '{"function":"ReadAsset","Args":["'$1'"]}'
