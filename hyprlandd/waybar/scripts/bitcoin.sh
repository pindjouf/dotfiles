#!/bin/bash

PRICE=$(curl -s https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT | jq -r '.price')

if [ -n "$PRICE" ]; then
    FORMATTED_PRICE=$(printf "%.2f" $PRICE)
    echo "{\"text\": \"   $FORMATTED_PRICE\", \"class\": \"bitcoin\"}"
else
    echo "{\"text\": \"Error fetching price\", \"class\": \"error\"}"
fi
