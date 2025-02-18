  #!/bin/bash

  # URL архива VK Teams
  URL="https://vkteams-www.hb.bizmrg.com/linux/x64/vkteams.tar.xz"
  
  # Папка для установки
  INSTALL_DIR="$HOME/.local/share/vkteams"
  
  # Создаём временную папку
  TMP_DIR=$(mktemp -d)
  
  echo "Скачиваю VK Teams..."
  curl -L -o "$TMP_DIR/vkteams.tar.xz" "$URL"
  
  echo "Распаковываю..."
  mkdir -p "$INSTALL_DIR"
  tar -xf "$TMP_DIR/vkteams.tar.xz" -C "$INSTALL_DIR"
  
  # Удаляем временные файлы
  rm -rf "$TMP_DIR"
  
  # Создаём ярлык для удобного запуска
  echo "[Desktop Entry]
  Name=VK Teams
  Exec=$INSTALL_DIR/vkteams
  Icon=$INSTALL_DIR/icon.png
  Type=Application
  Categories=Network;" > ~/.local/share/applications/vkteams.desktop
  
  chmod +x ~/.local/share/applications/vkteams.desktop
  
  echo "Установка завершена! Запустить можно командой: $INSTALL_DIR/vkteams"