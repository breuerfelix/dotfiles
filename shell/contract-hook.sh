#!/bin/bash
FILE=$1
MSG=$(cat $FILE)
TICKET=$(git branch --show-current | grep -E -i -o '(contract-)?[0-9]{4,}' | tr '[:lower:]' '[:upper:]')
[[ -z $TICKET ]] && exit 0
[[ $TICKET != *"CONTRACT-"* ]] && TICKET="CONTRACT-$TICKET"
[[ $MSG == *"Ref: $TICKET"* ]] && exit 0

echo -en "$MSG\n\nRef: $TICKET" > $FILE
