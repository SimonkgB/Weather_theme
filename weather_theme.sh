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
elif [[ "$DESC" == *"snow"* ]] || [ "$TEMP" -lt 0 ]; then
    THEME="nordic_winter"
elif [[ "$DESC" == *"rain"* ]] || [[ "$DESC" == *"drizzle"* ]]; then
    THEME="rainy_day"
elif [[ "$DESC" == *"fog"* ]] || [[ "$DESC" == *"mist"* ]] || [[ "$DESC" == *"haze"* ]]; then
    THEME="atmospheric"
elif [[ "$DESC" == *"cloudy"* ]] || [[ "$DESC" == *"overcast"* ]]; then
    THEME="gloomy_overcast"
elif [[ "$DESC" == *"sunny"* ]] || [[ "$DESC" == *"clear"* ]]; then
    if [ "$TEMP" -gt 22 ]; then
        THEME="bright_summer"
    else
        THEME="default_dark"
    fi
else
    THEME="default_dark"
fi



echo "Mode: $THEME ($DESC at ${TEMP}C)"


# exec

wal --theme "$THEME"
