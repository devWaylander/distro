#!/bin/bash

USER_NAME="$SUDO_USER"

# Проверим, используется ли Gnome Keyring
if [[ "$SSH_AUTH_SOCK" == *keyring* ]]; then
    echo "Используется Gnome Keyring для управления ключами."
else
    echo "SSH агент не запущен, запуск..."
    eval "$(ssh-agent -s)"
fi

SSH_DIR="/home/$USER_NAME/.ssh"

# Проверим, существует ли директория с ключами
if [[ ! -d "$SSH_DIR" ]]; then
    echo "Директория $SSH_DIR не существует."
    exit 1
fi

echo "Папка с ключами: $SSH_DIR"

# Правильные права на директорию и файлы
chmod 700 "$SSH_DIR"
chmod 600 "$SSH_DIR"/*
chmod 644 "$SSH_DIR"/*.pub 2>/dev/null

# Флаг для проверки, был ли добавлен хотя бы один ключ
key_added=false

# Добавляем все закрытые ключи в агент
for key in "$SSH_DIR"/id_*; do
    if [[ -f "$key" && "$key" != *.pub ]]; then
        echo "Добавляем ключ: $key"
        if ssh-add "$key"; then
            key_added=true
        else
            echo "Не удалось добавить ключ: $key"
        fi
    fi
done

# Проверка, был ли добавлен хотя бы один ключ
if ! $key_added; then
    echo "Ошибка: Не найдено ни одного ключа для добавления."
    exit 1
fi

# Проверяем список загруженных ключей
echo "Загруженные SSH-ключи:"
ssh-add -l

echo "SSH-ключи настроены!"

