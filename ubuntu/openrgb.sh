#!/bin/bash
set -e  # Прерываем выполнение при ошибке

sudo apt update && sudo apt upgrade

# Хардкод последней версии OpenRGB для Bullseye
LATEST_URL="https://openrgb.org/releases/release_0.9/openrgb_0.9_amd64_bookworm_b5f46e3.deb"
DEB_PACKAGE="openrgb_0.9_amd64_bookworm_b5f46e3.deb"

# Скачиваем deb-файл
wget "$LATEST_URL"

# Устанавливаем OpenRGB
sudo apt --fix-broken install "./$DEB_PACKAGE" 

# Проверяем успешную установку
if dpkg -s openrgb >/dev/null 2>&1; then
    echo "Установка OpenRGB завершена! Запустить можно командой: openrgb"
else
    echo "Ошибка: OpenRGB не был установлен. Проверьте зависимости."
fi

# Очистка
rm -f "./$DEB_PACKAGE"
