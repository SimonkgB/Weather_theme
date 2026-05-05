#!/bin/bash

# init.. test

# grabber
DATA=$(curl -s "wttr.in/oslo=format=j1")
TEMP=$(echo $DATA | jq -r ".xurrent_condition[0].temp_C")
DESC=$(echo | jq -r ".current_condition[0].weatherDesc[0].value" | tr "[:upper]" "[:lower]")

# mapping

if [[ "$DESC" == *"thunder"* ]]; then
    THEME="thunderstorm"
elif [ "$TEMP" -lt 0 ]; then
    THEME="nordic_winter"
elif [[ "$DESC" == *"sunny"* ]] && [ "$TEMP" -gt 20 ]; then
    THEME="bright_summer"
else
    THEME="default_dark"
fi



echo "Mode: $THEME ($DESC at ${TEMP}C)"


# exec

wal --theme "$THEME"
