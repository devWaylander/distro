#!/bin/bash

# Проверяем, установлен ли Go
if command -v go &> /dev/null; then
    echo "Go уже установлен. Версия: $(go version)"
    exit 0
fi

# Получаем последнюю версию Go с помощью API
GO_VERSION=$(curl -s --max-time 10 https://go.dev/VERSION?m=text | head -n 1)

# Проверяем, что версия Go найдена и корректна
if [[ -z "$GO_VERSION" || ! "$GO_VERSION" =~ ^go[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Ошибка: Не удалось получить корректную версию Go. Проверьте URL или интернет-соединение."
    exit 1
fi

# Формируем URL для загрузки
GO_TAR="$GO_VERSION.linux-amd64.tar.gz"
GO_DOWNLOAD_URL="https://go.dev/dl/$GO_TAR"

# Проверяем, был ли скачан файл с Go
if [ -f "$GO_TAR" ]; then
    rm -f "$GO_TAR"
fi

echo "Загружаю $GO_DOWNLOAD_URL..."
curl -LO "$GO_DOWNLOAD_URL"

# Проверяем успешность загрузки
if [ ! -f "$GO_TAR" ]; then
    echo "Ошибка: Не удалось загрузить $GO_TAR."
    exit 1
fi

# Распаковываем Go в /usr/local
echo "Распаковываю Go..."
sudo tar -C /usr/local -xzf "$GO_TAR"

# Удаляем скачанный архив
rm -f "$GO_TAR"

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
