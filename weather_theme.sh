#!/bin/bash

# init.. test

# grabber
THEME_DIR="$HOME/.config/weather_themes"

LOCATION=${1:-""} # apparantly this is auto configured
RAW_DATA=$(curl -s --max-time 10 "wttr.in/$LOCATION?format=j1")

if echo "$RAW_DATA" | jq empty 2>/dev/null; then
    TEMP=$(echo "$RAW_DATA" | jq -r '.current_condition[0].temp_C')
    DESC=$(echo "$RAW_DATA" | jq -r '.current_condition[0].weatherDesc[0].value' | tr '[:upper:]' '[:lower:]')
else
    # fb
    TEMP=20
    DESC="clear"
fi



#mapping

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
