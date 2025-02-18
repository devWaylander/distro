#!/bin/bash

# Функция для получения списка доступных версий Go с официального сайта
get_available_versions() {
    echo "Получаю доступные версии Go..."
    curl -s https://golang.org/dl/ | grep -oP 'go[0-9]+\.[0-9]+\.[0-9]+\.linux-amd64\.tar\.gz' | sort -V
}

# Функция для установки Go
install_go() {
    local version=$1
    echo "Загружаю версию $version..."
    DOWNLOAD_URL="https://golang.org/dl/$version"
    
    curl -LO "$DOWNLOAD_URL"

    echo "Распаковываю $version..."
    sudo tar -C /usr/local -xzf "$version"

    rm "$version"

    # Обновляем переменные среды в ~/.profile
    echo "Обновляю переменные среды..."
    PROFILE_FILE="$HOME/.profile"

    if ! grep -q "GOROOT" "$PROFILE_FILE"; then
        echo -e "\n# Go Environment Variables" >> "$PROFILE_FILE"
        echo "export GOROOT=/usr/local/go" >> "$PROFILE_FILE"
        echo "export GOPATH=\$HOME/go" >> "$PROFILE_FILE"
        echo "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" >> "$PROFILE_FILE"
    fi

    # Применяем изменения в текущей сессии
    source "$PROFILE_FILE"

    # Проверяем установленную версию Go
    echo "Go установлен. Версия Go:"
    go version
}

# Получаем доступные версии
versions=$(get_available_versions)

echo "Доступные версии Go:"
echo "$versions"

# Запрашиваем у пользователя версию для установки
echo "Введите нужную версию Go из списка (например, go1.18.1):"
read selected_version

# Проверяем, что версия валидная
if [[ ! "$versions" =~ $selected_version ]]; then
    echo "Выбранная версия недоступна. Попробуйте снова."
    exit 1
fi

# Проверка текущей установленной версии
current_version=$(go version | grep -oP 'go[0-9]+\.[0-9]+\.[0-9]+')

if [[ "$current_version" == "$selected_version" ]]; then
    echo "Вы уже установили эту версию Go ($selected_version)."
else
    echo "Устанавливаю выбранную версию Go..."
    install_go "$selected_version"
fi
