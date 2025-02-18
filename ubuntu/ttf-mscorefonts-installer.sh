#!/bin/bash

# Обновление списка пакетов
echo "Обновление списка пакетов..."
sudo apt update

# Установка ttf-mscorefonts-installer
echo "Установка ttf-mscorefonts-installer..."
sudo apt install -y ttf-mscorefonts-installer

# Принятие лицензионного соглашения
echo "Принятие лицензионного соглашения..."
sudo dpkg-reconfigure ttf-mscorefonts-installer

echo "Установка завершена."

