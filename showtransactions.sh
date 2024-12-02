#!/bin/bash

# Configuration
CHANNEL_NAME="mychannel"
ORDERER_ADDRESS="orderer.example.com:7050"
TLS_CA_FILE="${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt"

# Temporary directory for storing blocks
TEMP_DIR="./temp_blocks"
mkdir -p $TEMP_DIR

# Get the blockchain height
echo "Fetching blockchain information for channel '$CHANNEL_NAME'..."
BLOCKCHAIN_INFO=$(peer channel getinfo -c $CHANNEL_NAME '.height')
BLOCK_HEIGHT=$((BLOCKCHAIN_INFO - 1))
echo "Blockchain height: $((BLOCK_HEIGHT + 1)) blocks"

# Iterate over each block
for BLOCK_NUM in $(seq 0 $BLOCK_HEIGHT); do
    echo "Processing Block: $BLOCK_NUM..."

    # Fetch the block
    peer channel fetch $BLOCK_NUM $TEMP_DIR/block_$BLOCK_NUM.block -o $ORDERER_ADDRESS -c $CHANNEL_NAME --tls --cafile $TLS_CA_FILE > /dev/null 2>&1

    # Decode the block to JSON
    configtxlator proto_decode --input $TEMP_DIR/block_$BLOCK_NUM.block --type common.Block --output $TEMP_DIR/block_$BLOCK_NUM.json

    # Extract transactions and their timestamps
    TRANSACTIONS=$(jq -r '.data.data[] | .payload.header | "\(.channel_header.tx_id) \(.channel_header.timestamp)"' $TEMP_DIR/block_$BLOCK_NUM.json)

    # Display transactions
    if [ -z "$TRANSACTIONS" ]; then
        echo "  No transactions in this block."
    else
        echo "$TRANSACTIONS" | while read -r TX_ID TX_TIMESTAMP; do
            # Format and display
            FORMATTED_DATE=$(date -d "$TX_TIMESTAMP" +"%Y-%m-%d %H:%M:%S")
            echo "  Transaction ID: $TX_ID"
            echo "  Timestamp: $FORMATTED_DATE"
        done
    fi
done

# Clean up temporary files
rm -rf $TEMP_DIR
echo "Done."

