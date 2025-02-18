#!/bin/bash

# Устанавливаем строгие настройки: если одна команда завершится с ошибкой, скрипт остановится
set -e

# Выдаем разрешение на выполнение всем скриптам
chmod +x *.sh

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
  "ttf-mscorefonts-installer.sh"
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
  "ssh-import.sh"
)

echo "Запуск главного скрипта для установки..."

# Проходим по всем скриптам и выполняем их
for script in "${scripts[@]}"; do
  echo "Запуск $script..."
  if ! yes | ./$script; then
    echo "Ошибка при выполнении $script. Прерывание."
    exit 1
  fi
done

echo "Все скрипты выполнены успешно!"

# Установка и обновление GRUB
# Определяем системный диск (где смонтирован корень "/")
SYSTEM_DISK=$(lsblk -no PKNAME $(df / | awk 'NR==2 {print $1}'))

if [ -z "$SYSTEM_DISK" ]; then
    echo "Ошибка: Не удалось определить системный диск!"
    exit 1
fi

SYSTEM_DISK="/dev/$SYSTEM_DISK"
echo "Определён системный диск: $SYSTEM_DISK"

# Проверяем, есть ли строка GRUB_DISABLE_OS_PROBER в /etc/default/grub
if grep -q "^GRUB_DISABLE_OS_PROBER" /etc/default/grub; then
    # Если строка есть, заменяем true на false
    sudo sed -i 's/^GRUB_DISABLE_OS_PROBER=.*/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub
else
    # Если строки нет, добавляем её в конец файла
    echo "GRUB_DISABLE_OS_PROBER=false" | sudo tee -a /etc/default/grub
fi

# Устанавливаем GRUB на системный диск
echo "Установка GRUB на $SYSTEM_DISK..."
sudo grub-install "$SYSTEM_DISK"

# Обновляем конфигурацию GRUB
echo "Обновление конфигурации GRUB..."
sudo update-grub

echo "Готово! Перезагрузите компьютер, чтобы проверить GRUB."

