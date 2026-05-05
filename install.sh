#!/bin/bash

mkdir -p ~/.config/weather_themes

cp weather_theme.sh ~/.local/bin/
cp systemd/weather_theme.* ~/.config/systemd/user

chmod +x ~/.local/bin/weather_theme.sh

systemctl --user daemon-reload
systemctl --user enable --now weather_theme.timer

echo "shit started... wooooo!"
