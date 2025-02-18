#!/bin/bash

# Устанавливаем nvm
echo "Устанавливаю nvm..."
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash

# Перезагружаем текущую сессию оболочки, чтобы nvm стал доступен
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Устанавливаем последнюю стабильную версию Node.js
echo "Устанавливаю последнюю стабильную версию Node.js..."
nvm install --lts

# Проверяем установленную версию Node.js
echo "Последняя стабильная версия Node.js установлена. Версия:"
node -v
