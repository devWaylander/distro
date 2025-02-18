#!/bin/bash

# URL архива VK Teams
URL="https://vkteams-www.hb.bizmrg.com/linux/x64/vkteams.tar.xz"

# Получаем домашнюю директорию текущего пользователя
USER_HOME=$(eval echo ~$SUDO_USER)

# Папка для установки
INSTALL_DIR="$USER_HOME/.local/share/vkteams"

# Папка для создания симлинка
BIN_DIR="/usr/local/bin"

# Создаём временную папку
TMP_DIR=$(mktemp -d)

# Функция для проверки ошибки после каждой команды
check_exit_status() {
    if [ $? -ne 0 ]; then
        echo "Ошибка: команда $1 не выполнена успешно."
        exit 1
    fi
}

echo "Скачиваю VK Teams..."
curl -L -o "$TMP_DIR/vkteams.tar.xz" "$URL"
check_exit_status "curl"

echo "Распаковываю..."
mkdir -p "$INSTALL_DIR"
check_exit_status "mkdir"
tar -xf "$TMP_DIR/vkteams.tar.xz" -C "$INSTALL_DIR"
check_exit_status "tar"

# Удаляем временные файлы
rm -rf "$TMP_DIR"
check_exit_status "rm"

# Создаём ярлык для удобного запуска
echo "[Desktop Entry]
Name=VK Teams
Exec=$INSTALL_DIR/vkteams
Type=Application
Categories=Network;" > "$USER_HOME/.local/share/applications/vkteams.desktop"
check_exit_status "echo (desktop entry)"

chmod +x "$USER_HOME/.local/share/applications/vkteams.desktop"
check_exit_status "chmod"

# Создаём симлинк для команды vkteams
echo "Создаю символическую ссылку для команды vkteams..."
sudo ln -sf "$INSTALL_DIR/vkteams" "$BIN_DIR/vkteams"
check_exit_status "ln"

echo "Установка завершена! Запустить можно командой: vkteams"
