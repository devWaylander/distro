#!/bin/bash

USER_HOME=$(eval echo ~$SUDO_USER)
PROFILE_FILE="$USER_HOME/.profile"

# Проверяем, установлен ли Go
if sudo -u "$SUDO_USER" command -v go &> /dev/null; then
    echo "Go уже установлен. Версия: $(sudo -u "$SUDO_USER" go version)"
    exit 0
fi

# Получаем последнюю версию Go
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
tar -C /usr/local -xzf "$GO_TAR"

# Удаляем скачанный архив
rm -f "$GO_TAR"

# Прописываем переменные среды в ~/.profile пользователя
echo "Обновляю переменные среды в $PROFILE_FILE..."
sudo -u "$SUDO_USER" bash -c "echo -e '\n# Go Environment Variables' >> $PROFILE_FILE"
sudo -u "$SUDO_USER" bash -c "echo 'export GOROOT=/usr/local/go' >> $PROFILE_FILE"
sudo -u "$SUDO_USER" bash -c "echo 'export GOPATH=\$HOME/go' >> $PROFILE_FILE"
sudo -u "$SUDO_USER" bash -c "echo 'export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin' >> $PROFILE_FILE"

# Применяем изменения
sudo -u "$SUDO_USER" bash -c "source $PROFILE_FILE"

# Проверяем установленную версию Go
sudo -u "$SUDO_USER" bash -c "source $PROFILE_FILE && echo 'Go установлен. Версия:' && go version"

