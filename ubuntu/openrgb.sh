#!/bin/bash

# Скачиваем .deb пакет
wget https://openrgb.org/releases/release_0.9/openrgb_0.9_amd64_bullseye_b5f46e3.deb

# Устанавливаем .deb пакет
sudo dpkg -i openrgb_0.9_amd64_bullseye_b5f46e3.deb

# Если возникли проблемы с зависимостями, исправляем их
sudo apt --fix-broken install