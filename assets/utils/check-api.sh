#!/bin/bash

DURATION=$(</dev/stdin)
if (($DURATION <= 4000)); then
    echo "JAM Web API may take a while to start, please be patient..."
    exit 60
else
    if [ $(find /root/.joinmarket/wallets -type f -iname ".*.jmdat.lock" | wc -l) != 0 ]
    then 
        echo "JAM wallet(s) are locked. Use the 'Unlock Wallet' action to continue" >&2
        exit 61
    fi
    if ! curl -sSL --silent --fail --insecure https://jam.embassy:28183/api/v1/session &>/dev/null; then
        echo "JAM API is unreachable" >&2
        exit 1
    fi
fi
