#!/bin/bash


systemctl --user stop weather_theme.timer 2>/dev/null
systemctl --user disable weather_theme.timer 2>/dev/null
systemctl --user stop weather_theme.service 2>/dev/null


rm -f ~/.local/bin/weather_theme.sh
rm -f ~/.config/systemd/user/weather_theme.service
rm -f ~/.config/systemd/user/weather_theme.timer
rm -rf  ~/.config/weather_themes

# rm -rf ~/.config/weather_themes



systemctl --user daemon-reload
systemctl --user reset-failed

# Remove pywal hook block from zshrc
sed -i '/# BEGIN weather_theme/,/# END weather_theme/d' ~/.zshrc
sed -i '/^#weather theme$/d' ~/.zshrc
sed -i '/\[\[ -f ~\/.cache\/wal\/sequences \]\] && (cat ~\/.cache\/wal\/sequences &)/d' ~/.zshrc

rm -f ~/.cache/weather_theme_sequences

# i do not udnerstand these VVVV, but thats what stackoverflow said...
# Reset terminal colors back to defaults immediately
printf '\033]104\007'  # reset 16 color palette
printf '\033]110\007'  # reset default foreground
printf '\033]111\007'  # reset default background
printf '\033]112\007'  # reset cursor color

echo "Uninstall complete... womp womp."
