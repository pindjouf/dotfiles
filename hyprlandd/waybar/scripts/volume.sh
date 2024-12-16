#!/bin/bash

regex='^(100|[1-9]?[0-9](\.[0-9]{1,2})?)%$'
volume=$(amixer get Master | grep -o '[0-9]*%' | head -n 1)

volume_value=${volume%\%}

if [[ "$volume" =~ $regex ]]; then
    if [ "$volume_value" -eq 0 ]; then
        icon='󰝟 '
    elif [ "$volume_value" -lt 34 ]; then
        icon=' '
    elif [ "$volume_value" -lt 67 ]; then
        icon='  '
    else
        icon='  '
    fi
    
    echo "{\"text\": \" $icon\", \"class\": \"volume\"}" | jq --unbuffered --compact-output
else
    echo "naaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaah"
fi
