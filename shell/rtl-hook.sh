#!/bin/bash
FILE=$1
MSG=$(cat $FILE)

NUMBER=$(git branch --show-current | grep -E -i -o '[0-9]{4,}' | tr '[:lower:]' '[:upper:]')
[[ -z $NUMBER ]] && exit 0

SQUAD=$(basename $(dirname $(git rev-parse --show-toplevel)) | tr '[:lower:]' '[:upper:]')
[[ -z $SQUAD ]] && exit 0

TICKET="$SQUAD-$NUMBER"
[[ $MSG == *"Ref: $TICKET"* ]] && exit 0

echo -en "$MSG\n\nRef: $TICKET" > $FILE
