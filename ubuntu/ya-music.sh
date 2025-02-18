#!/bin/bash

# URL для API GitHub
API_URL="https://api.github.com/repos/cucumber-sp/yandex-music-linux/releases/latest"

echo "Получаю последнюю версию Yandex Music..."
LATEST_VERSION=$(curl -sL "$API_URL" | jq -r '.tag_name' | sed 's/^v//')

if [[ -z "$LATEST_VERSION" ]]; then
    echo "Не удалось найти последнюю версию. Проверьте API или интернет-соединение."
    exit 1
fi

echo "Последняя версия: $LATEST_VERSION"

# Проверяем, установлен ли Yandex Music
if ! dpkg -l | grep -q "yandex-music"; then
    echo "Yandex Music не установлен. Устанавливаю последнюю версию..."
    
    # Формируем URL для скачивания
    DEB_URL="https://github.com/cucumber-sp/yandex-music-linux/releases/download/v$LATEST_VERSION/yandex-music_${LATEST_VERSION}_amd64.deb"

    # Создаём временный файл
    TMP_DEB=$(mktemp --suffix=.deb)

    echo "Скачиваю $DEB_URL..."
    curl -L -o "$TMP_DEB" "$DEB_URL"

    echo "Устанавливаю Yandex Music..."
    sudo dpkg -i "$TMP_DEB" || sudo apt-get install -f -y

    # Удаляем временный файл
    rm -f "$TMP_DEB"

    echo "Yandex Music установлен!"
else
    echo "Yandex Music уже установлен, проверяю версию..."

    # Проверяем установленную версию Yandex Music
    INSTALLED_VERSION=$(dpkg -s yandex-music | grep '^Version:' | awk '{print $2}')

    echo "Установленная версия Yandex Music: $INSTALLED_VERSION"

    # Сравниваем установленную версию с последней
    if [[ "$INSTALLED_VERSION" == "$LATEST_VERSION" ]]; then
        echo "Версия актуальна!"
    else
        echo "Версия устарела. Последняя доступная версия: $LATEST_VERSION"
        
        # Формируем URL для скачивания
        DEB_URL="https://github.com/cucumber-sp/yandex-music-linux/releases/download/v$LATEST_VERSION/yandex-music_${LATEST_VERSION}_amd64.deb"

        # Создаём временный файл
        TMP_DEB=$(mktemp --suffix=.deb)

        echo "Скачиваю $DEB_URL..."
        curl -L -o "$TMP_DEB" "$DEB_URL"

        echo "Обновляю Yandex Music..."
        sudo dpkg -i "$TMP_DEB" || sudo apt-get install -f -y

        # Удаляем временный файл
        rm -f "$TMP_DEB"

        echo "Yandex Music обновлён до последней версии!"
    fi
fi

echo "Запустить можно командой: yandex-music"
