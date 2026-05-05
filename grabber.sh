#!/bin/bash

# init.. test

# grabber
DATA = $(curl -s "wttr.in/oslo=format=j1")
TEMP = $(echo $DATA | jq -r ".xurrent_condition[0].temp_C")
DESC = $(echo | jq -r ".current_condition[0].weatherDesc[0].value" | tr "[:upper]" "[:lower]")

# mapping

if [["$DESC" == *"thunder"* ]]; then
	theme="thunderstrom"
elif [ "$TEMP" -lt 0 ]; then
	THEME="nordic_winther"
elif [[ "$DESC" == *"sunny"* ]] && [ "$TEMP" -gt 20]; then
	THEME="bright_summer"
else
	THEME="default_dark"
fi


# exec

wal --theme "$THEME"
