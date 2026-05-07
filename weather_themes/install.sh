#!/bin/bash

REPO_PATH=$(pwd)

mkdir -p ~/.config/weather_theme/themes
mkdir -p ~/.config/systemd/user
mkdir -p ~/.local/bin

cp "$REPO_PATH/weather_theme.sh" ~/.config/weather_theme/weather_theme.sh
cp "$REPO_PATH/uninstall.sh" ~/.config/weather_theme/uninstall.sh
cp -r "$REPO_PATH/weather_themes/." ~/.config/weather_theme/themes/
cp "$REPO_PATH/systemd/weather_theme.service" ~/.config/systemd/user/weather_theme.service
cp "$REPO_PATH/systemd/weather_theme.timer" ~/.config/systemd/user/weather_theme.timer

ln -sf ~/.config/weather_theme/weather_theme.sh ~/.local/bin/weather_theme.sh

chmod +x ~/.local/bin/weather_theme.sh

systemctl --user daemon-reload
systemctl --user enable --now weather_theme.timer
systemctl --user start weather_theme.service

#pywal sequences hook to zshrc if not already present
ZSHRC_MARKER="# BEGIN weather_theme"
if ! grep -qF "$ZSHRC_MARKER" ~/.zshrc; then
    cat >> ~/.zshrc <<'EOF'

# BEGIN weather_theme
[[ -f ~/.cache/weather_theme_sequences ]] && (cat ~/.cache/weather_theme_sequences &)
# END weather_theme
EOF
fi

echo "shit started... wooooo!"
