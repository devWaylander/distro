#!/bin/bash

# Обновляем пакеты и устанавливаем необходимые зависимости
sudo apt-get update
sudo apt-get install -y ca-certificates curl

# Создаём каталог для ключей APT, если он отсутствует
sudo install -m 0755 -d /etc/apt/keyrings

# Загружаем и добавляем GPG-ключ Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Определяем версию Ubuntu и добавляем репозиторий Docker
. /etc/os-release
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $VERSION_CODENAME stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Обновляем списки пакетов
sudo apt-get update

# Устанавливаем Docker и необходимые компоненты
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Добавляем текущего пользователя в группу docker (чтобы не использовать sudo при запуске контейнеров)
echo "Добавляю пользователя в группу docker для использования без root..."
sudo usermod -aG docker "$USER"

# Проверяем успешность установки Docker
newgrp docker <<EOC
    docker run hello-world
EOC

# Выводим сообщение о необходимости выхода из системы или перезагрузки
echo "Чтобы изменения вступили в силу, выйдите из системы и войдите снова (или перезагрузите систему)."

