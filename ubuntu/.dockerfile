FROM ubuntu:24.04

# Устанавливаем необходимые зависимости, включая sudo
RUN apt-get update && apt-get install -y \
    apt-utils \
    curl \
    wget \
    tar \
    gpg \
    ca-certificates \
    dbus \
    flatpak \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Добавляем репозиторий Flathub с правами root
RUN flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Копируем все скрипты в контейнер
COPY . /root/ubuntu

# Устанавливаем рабочую директорию
WORKDIR /root/ubuntu

# Даем права на выполнение всех скриптов
RUN chmod +x *.sh

# Запускаем основной скрипт
CMD ["bash", "main.sh"]
