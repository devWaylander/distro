#!/bin/bash

# Устанавливаем строгие настройки: если одна команда завершится с ошибкой, скрипт остановится
set -e

# Массив с именами скриптов
scripts=(
  "antaressql.sh"
  "docker.sh"
  "easy-effects.sh"
  "obsidian.sh"
  "openrgb.sh"
  "vlc.sh"
  "ya-browser.sh"
  "discord.sh"
  # exactly in that order
  "obs.sh"
  "droidcam.sh"
  #   
  "pano.sh"
  "vkteams.sh"
  "ya-music.sh"
  "vscode.sh"
  "go.sh"
  "nvm.sh"
)

echo "Запуск главного скрипта для установки..."

# Проходим по всем скриптам и выполняем их
for script in "${scripts[@]}"; do
  echo "Запуск $script..."
  ./$script
done

echo "Все скрипты выполнены успешно!"
