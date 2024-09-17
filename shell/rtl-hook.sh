#!/bin/bash
FILE=$1
MSG=$(cat "$FILE")

T=$(git branch --show-current | grep -E -i -o '^[A-Za-z]+-[0-9]+')
[[ -z $T ]] && exit 0

TICKET=$(echo "$T" | tr '[:lower:]' '[:upper:]')

[[ $MSG == *"Refs: $TICKET"* ]] && exit 0

echo -en "$MSG\n\nRefs: $TICKET" > "$FILE"
