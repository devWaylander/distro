#!/bin/bash

# Обновляем пакеты и устанавливаем необходимые зависимости
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Добавляем репозиторий Docker в источники APT
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Устанавливаем Docker и необходимые компоненты
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Настроим Docker для работы без root (добавим пользователя в группу docker)
echo "Добавляю пользователя в группу docker для использования без root..."
sudo usermod -aG docker $USER

# Подаем команду для проверки установки Docker
sudo docker run hello-world

# Сообщение о необходимости перезагрузки или выхода из системы
echo "Чтобы изменения вступили в силу, необходимо выйти из системы и войти снова (или перезагрузить систему)."
