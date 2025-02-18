#!/bin/bash

echo "Добавляю репозиторий Яндекс Браузера..."
wget -qO - https://repo.yandex.ru/yandex-browser/YANDEX-BROWSER-KEY.GPG | sudo apt-key add -
echo "deb [arch=amd64] http://repo.yandex.ru/yandex-browser/deb stable main" | sudo tee /etc/apt/sources.list.d/yandex-browser.list

echo "Обновляю список пакетов..."
sudo apt update

echo "Устанавливаю Yandex Browser..."
sudo apt install -y yandex-browser-stable

echo "Установка завершена! Запустить можно командой: yandex-browser"
