#!/bin/bash

USER_HOME=$(eval echo ~$SUDO_USER)
NVM_DIR="$USER_HOME/.nvm"

# Устанавливаем nvm для обычного пользователя
echo "Устанавливаю nvm для пользователя $SUDO_USER..."
sudo -u "$SUDO_USER" wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | sudo -u "$SUDO_USER" bash

# Добавляем nvm в ~/.profile пользователя
echo 'export NVM_DIR="$HOME/.nvm"' | sudo -u "$SUDO_USER" tee -a "$USER_HOME/.profile" > /dev/null
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' | sudo -u "$SUDO_USER" tee -a "$USER_HOME/.profile" > /dev/null
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' | sudo -u "$SUDO_USER" tee -a "$USER_HOME/.profile" > /dev/null

# Применяем изменения из ~/.profile
sudo -u "$SUDO_USER" bash -c "source $USER_HOME/.profile"

# Устанавливаем последнюю стабильную версию Node.js
echo "Устанавливаю последнюю стабильную версию Node.js..."
sudo -u "$SUDO_USER" bash -c "source $USER_HOME/.profile && nvm install --lts && nvm use --lts"

# Проверяем установленную версию Node.js
sudo -u "$SUDO_USER" bash -c "source $USER_HOME/.profile && echo 'Последняя стабильная версия Node.js установлена. Версия:' && node -v"

