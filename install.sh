#!/bin/bash




mkdir -p ~/.config/weather_themes

REPO_PATH=$(pwd)


ln -sf "$REPO_PATH/weather_theme.sh" ~/.local/bin/weather_theme.sh
ln -sf "$REPO_PATH/systemd/weather_theme.service" ~/.config/systemd/user/weather_theme.service
ln -sf "$REPO_PATH/systemd/weather_theme.timer" ~/.config/systemd/user/weather_theme.timer
ln -sfn "$REPO_PATH/themes" ~/.config/weather_themes

chmod +x ~/.local/bin/weather_theme.sh

systemctl --user daemon-reload
systemctl --user enable --now weather_theme.timer

echo "shit started... wooooo!"
