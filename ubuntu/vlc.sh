#!/bin/bash

# Устанавливаем VLC
sudo apt update
sudo apt install vlc

# Удаляем неиспользуемые пакеты
sudo apt autoremove

# Обновляем систему и устанавливаем дополнительные мультимедийные пакеты
sudo apt update
sudo apt upgrade
sudo apt install ubuntu-restricted-extras
