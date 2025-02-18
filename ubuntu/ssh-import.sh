#!/bin/bash

SSH_DIR="$HOME/.ssh"

# Устанавливаем правильные права
chmod 700 "$SSH_DIR"
chmod 600 "$SSH_DIR"/*
chmod 644 "$SSH_DIR"/*.pub 2>/dev/null

# Запускаем ssh-agent и добавляем все закрытые ключи
eval "$(ssh-agent -s)"

for key in "$SSH_DIR"/id_*; do
    if [[ -f "$key" && "$key" != *.pub ]]; then
        ssh-add "$key"
    fi
done

echo "SSH-ключи настроены!"

# Проверяем список загруженных ключей
ssh-add -l
