#!/bin/bash

# Установка Telegram на Linux

# Получаем домашнюю директорию текущего пользователя
USER_HOME=$(eval echo ~$SUDO_USER)
DOWNLOAD_DIR="$USER_HOME/Downloads"
INSTALL_DIR="/opt/telegram"

# Проверка, существует ли директория для скачивания
if [ ! -d "$DOWNLOAD_DIR" ]; then
    echo "Ошибка: Директория для скачивания $DOWNLOAD_DIR не существует."
    exit 1
fi

# Создаем папку для установки, если она не существует
mkdir -p "$INSTALL_DIR"

# Скачиваем Telegram
echo "Скачиваю Telegram..."
curl -L https://telegram.org/dl/desktop/linux -o "$DOWNLOAD_DIR/telegram.tar.xz" || { echo "Ошибка при скачивании Telegram."; exit 1; }

# Проверяем, был ли успешно скачан архив
if [ ! -f "$DOWNLOAD_DIR/telegram.tar.xz" ]; then
    echo "Ошибка: Скачанный архив не найден."
    exit 1
fi

# Распаковываем архив
echo "Распаковываю Telegram..."
tar -xvf "$DOWNLOAD_DIR/telegram.tar.xz" -C "$INSTALL_DIR" || { echo "Ошибка при распаковке архива Telegram."; exit 1; }

# Убираем скачанный архив
rm "$DOWNLOAD_DIR/telegram.tar.xz" || { echo "Ошибка при удалении скачанного архива."; exit 1; }

# Создаем символическую ссылку для удобства запуска
echo "Создаю символическую ссылку..."
sudo ln -sf "$INSTALL_DIR/Telegram/Telegram" /usr/local/bin/telegram || { echo "Ошибка при создании символической ссылки."; exit 1; }

echo "Telegram установлен успешно!"
echo "Вы можете запустить его, введя 'telegram' в командной строке."
