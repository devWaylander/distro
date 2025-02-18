#!/bin/bash

# Убедитесь, что jq установлен
if ! command -v jq &> /dev/null
then
    echo "jq не установлен, устанавливаю..."
    sudo apt update && sudo apt install -y jq
fi

# Зависимости
sudo apt install gir1.2-gda-5.0 gir1.2-gsound-1.0
sudo apt install gnome-shell-extension-manager

# Получение URL для скачивания первого релиза из списка
url=$(curl -s https://api.github.com/repos/oae/gnome-shell-pano/releases | jq -r '.[0].assets[0].browser_download_url')

# Скачивание расширения
echo "Скачиваю расширение..."
curl -L -o gnome-shell-pano.zip "$url"

# Определение папки для установки
extension_folder="/home/$SUDO_USER/.local/share/gnome-shell/extensions/pano@elhan.io"

# Распаковка расширения в нужную директорию
echo "Распаковываю расширение..."
mkdir -p "$extension_folder"
unzip gnome-shell-pano.zip -d "$extension_folder"

# Включение расширения
echo "Включаю расширение..."
gnome-extensions enable pano@elhan.io

# Очистка
rm gnome-shell-pano.zip

echo "Установка завершена!"
