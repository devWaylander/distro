#!/bin/bash

# Получаем последнюю версию Go с официального сайта
GO_VERSION=$(curl -s https://golang.org/dl/ | grep -oP 'go[0-9]+\.[0-9]+\.[0-9]+\.linux-amd64.tar.gz' | head -n 1)

# Проверяем, что версия Go найдена
if [ -z "$GO_VERSION" ]; then
    echo "Не удалось получить последнюю версию Go."
    exit 1
fi

# Загружаем архив с последней версией Go
GO_DOWNLOAD_URL="https://golang.org/dl/$GO_VERSION"
echo "Загружаю $GO_DOWNLOAD_URL..."
curl -LO "$GO_DOWNLOAD_URL"

# Распаковываем архив
echo "Распаковываю Go..."
sudo tar -C /usr/local -xzf "$GO_VERSION"

# Удаляем скачанный архив
rm "$GO_VERSION"

# Прописываем переменные среды в ~/.profile
echo "Обновляю переменные среды в ~/.profile..."
PROFILE_FILE="$HOME/.profile"

if ! grep -q "GOROOT" "$PROFILE_FILE"; then
    echo -e "\n# Go Environment Variables" >> "$PROFILE_FILE"
    echo "export GOROOT=/usr/local/go" >> "$PROFILE_FILE"
    echo "export GOPATH=\$HOME/go" >> "$PROFILE_FILE"
    echo "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" >> "$PROFILE_FILE"
fi

# Применяем изменения в текущей сессии
source "$PROFILE_FILE"

# Проверяем установленную версию Go
echo "Go установлен. Версия Go:"
go version
