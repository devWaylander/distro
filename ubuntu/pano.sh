#!/bin/bash

# URL страницы релизов
RELEASES_URL="https://github.com/oae/gnome-shell-pano/releases"

# Установка необходимых зависимостей
echo "Устанавливаю зависимости..."
sudo apt update
sudo apt install -y gir1.2-gda-5.0 gir1.2-gsound-1.0

echo "Получаю последнюю версию с меткой 'latest'..."
LATEST_URL=$(curl -sL "$RELEASES_URL" | grep -oP 'href="\K[^"]+(?=")' | grep -E 'gnome-shell-pano-.*latest.*\.tar\.gz' | head -n 1)

if [[ -z "$LATEST_URL" ]]; then
    echo "Не удалось найти файл с меткой 'latest'. Проверьте URL или интернет-соединение."
    exit 1
fi

# Формируем полный URL для скачивания
FULL_URL="https://github.com$LATEST_URL"

echo "Скачиваю $FULL_URL..."
TMP_FILE=$(mktemp --suffix=.tar.gz)

curl -L -o "$TMP_FILE" "$FULL_URL"

echo "Распаковываю файл..."
# Распаковка архива
tar -xvzf "$TMP_FILE" -C /tmp

# Устанавливаем в нужное место (если нужно, например, в /usr/local)
echo "Устанавливаю Gnome Shell Pano..."
# Пример установки, смотрите инструкции в README репозитория
sudo mv /tmp/gnome-shell-pano-*/ /usr/local/share/gnome-shell/extensions/

# Удаляем временный файл
rm -f "$TMP_FILE"

echo "Установка завершена! Перезапустите Gnome Shell или перезагрузите систему."
