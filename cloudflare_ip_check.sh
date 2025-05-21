#! /bin/bash

echo "Checking for new IPs..."

CACHE_FILE="./cf_ipv4_cache.txt"
TEMP_FILE=$(mktemp)

curl -s https://api.cloudflare.com/client/v4/ips | jq -r ".result.ipv4_cidrs[]" | sort > "$TEMP_FILE"

if [ ! -f ./cf_ipv4_cache.txt ]; then
    cp "$TEMP_FILE" "$CACHE_FILE"
    echo -e "\e[1;34m[INFO]\e[0m Initialized cache at $CACHE_FILE"
    exit 0
fi

NEW_IPS=$(comm -13 "$CACHE_FILE" "$TEMP_FILE")
REMOVED_IPS=$(comm -23 "$CACHE_FILE" "$TEMP_FILE")

if [ -n "$NEW_IPS" ] || [ -n "$REMOVED_IPS" ]; then
        TIMESTAMP=$(date -u + "%Y-%m-%d %H:%M:%S UTC")
        MSG="Cloudflare IPv4 CIDRs changed at $TIMESTAMP"

        if [ -n "$NEW_IPS" ]; then
                MSG+="\n New IPs :\n$NEW_IPS"
        fi
        if [ -n "$REMOVED_IPS" ]; then
                MSG+="\n Removed IPs :\n$REMOVED_IPS"
        fi

        cp $TEMP_FILE $CACHE_FILE
else
        echo "No changes detected at $(date -u +"%Y-%m-%d %H:%M:%S UTC")"
fi


rm "$TEMP_FILE"
