#!/bin/bash

# Предварительная настройка debconf для автоматического принятия лицензии ttf-mscorefonts-installer
echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula boolean true" | sudo debconf-set-selections

# Установка необходимых зависимостей
sudo apt update
sudo apt install -y ca-certificates curl gpg apt-transport-https

# Добавление ключа и репозитория Microsoft для установки Visual Studio Code
sudo install -d /etc/apt/keyrings
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
sudo chmod a+r /etc/apt/keyrings/microsoft.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

# Обновление списка пакетов
sudo apt update

# Установка Visual Studio Code
sudo apt install -y code

