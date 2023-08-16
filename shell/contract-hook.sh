#!/bin/bash
FILE=$1
MSG=$(cat $FILE)
TICKET=$(git branch --show-current | grep -i -o 'contract-[0-9][0-9][0-9][0-9]' | tr '[:lower:]' '[:upper:]')
[[ -z $TICKET ]] && exit 0
[[ $MSG == *$TICKET* ]] && exit 0

echo -en "$MSG\n\nRef: $TICKET" > $FILE
