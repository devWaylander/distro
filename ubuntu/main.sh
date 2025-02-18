#!/bin/bash

# Устанавливаем строгие настройки: если одна команда завершится с ошибкой, скрипт остановится
set -e

# Устанавливаем flatpak, если его нет
if ! command -v flatpak &> /dev/null
then
    echo "Flatpak не найден, устанавливаем..."
    sudo apt update && sudo apt install -y flatpak
    # Добавляем репозиторий Flathub
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
else
    echo "Flatpak уже установлен."
fi

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
  "telegram.sh"
  "ya-music.sh"
  "vscode.sh"
  "go.sh"
  "nvm.sh"
)

echo "Запуск главного скрипта для установки..."

# Проходим по всем скриптам и выполняем их
for script in "${scripts[@]}"; do
  echo "Запуск $script..."
  yes | ./$script
done

echo "Все скрипты выполнены успешно!"
