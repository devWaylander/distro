#!/bin/bash

# Получаем последнюю версию Go с помощью API
GO_VERSION=$(curl -s https://go.dev/VERSION?m=text | head -n 1)

# Проверяем, что версия Go найдена
if [ -z "$GO_VERSION" ]; then
    echo "Не удалось получить последнюю версию Go."
    exit 1
fi

# Формируем URL для загрузки
GO_TAR="$GO_VERSION.linux-amd64.tar.gz"
GO_DOWNLOAD_URL="https://go.dev/dl/$GO_TAR"

echo "Загружаю $GO_DOWNLOAD_URL..."
curl -LO "$GO_DOWNLOAD_URL"

# Удаляем старую версию, если она есть
sudo rm -rf /usr/local/go

# Распаковываем Go в /usr/local
echo "Распаковываю Go..."
sudo tar -C /usr/local -xzf "$GO_TAR"

# Удаляем скачанный архив
rm "$GO_TAR"

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
