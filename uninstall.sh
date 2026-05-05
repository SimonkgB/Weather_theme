#!/bin/bash






systemctl --user stop weather-theme.timer 2>/dev/null
systemctl --user disable weather-theme.timer 2>/dev/null
systemctl --user stop weather-theme.service 2>/dev/null


rm -f ~/.local/bin/weather_theme.sh
rm -f ~/.config/systemd/user/weather_theme.service
rm -f ~/.config/systemd/user/weather_theme.timer

# rm -rf ~/.config/weather-themes



systemctl --user daemon-reload
systemctl --user reset-failed

echo "Uninstall complete... womp womp."
