# Distro
Settings for all my favorites distros

## Fedora
Soft
- [obsidian](https://flathub.org/apps/md.obsidian.Obsidian)
  ```sh
  flatpak install flathub md.obsidian.Obsidian
  ```
- [antaressql](https://flathub.org/apps/it.fabiodistasio.AntaresSQL)
  ```sh
  flatpak install flathub it.fabiodistasio.AntaresSQL
  ```
- [vscode](https://code.visualstudio.com/docs/setup/linux#_rhel-fedora-and-centos-based-distributions)
  ```sh
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee 
  /etc/yum.repos.d/vscode.repo > /dev/null
  ```
  ```sh
  dnf check-update
  sudo dnf install code
  ```
- [ya music](https://github.com/cucumber-sp/yandex-music-linux/releases)
- [ya browser](https://yandex.ru/support2/browser/ru/about/install#browser-install)
  ```sh
  sudo rpmkeys --import https://repo.yandex.ru/yandex-browser/YANDEX-BROWSER-KEY.GPG
  ```
  ```sh
  sudo dnf config-manager --add-repo http://repo.yandex.ru/yandex-browser/rpm/stable/x86_64
  ```
- [easy effects](https://github.com/wwmm/easyeffects)
  ```sh
  flatpak install flathub com.github.wwmm.easyeffects
  ```
- [droidcam](https://www.dev47apps.com/droidcam/linux/)
  ```sh
  dnf install akmod-v4l2loopback
  ```
- [pano](https://github.com/oae/gnome-shell-pano)
  ```sh
  sudo dnf install libgda libgda-sqlite
  ```
- [discord](https://flathub.org/apps/com.discordapp.Discord)
  ```sh
  flatpak install flathub com.discordapp.Discord
  ```
- [vk teams](https://biz.mail.ru/teams/download/)
- [openrgb](https://openrgb.org/)
  ```sh
  sudo dnf install openrgb
  ```
- [obs](https://obsproject.com/download#linux)
  ```sh
  sudo dnf install obs-studio
  ```
- [vlc](https://discussion.fedoraproject.org/t/codec-no-longer-supported/99880)
  ```sh
  sudo dnf install obs-studio
  sudo dnf autoremove
  sudo dnf group upgrade --with-optional Multimedia --allowerasing
  ```
Dev Dependencies
- [go](https://go.dev/doc/install)
- [nvm](https://github.com/nvm-sh/nvm)
  ```sh
  wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
  ```
- [docker](https://docs.docker.com/engine/install/fedora/#install-using-the-repository) with no-root
  ```sh
  systemctl enable docker
  ```
  
Common
1) Установить `Gnome Extension Manager`
   
   Найти в нём плагин `AppIndicator and KStatusNotifierItem Support` и установить его. Починятся уведомления от VK Teams + наконец-то запашут иконки трея. Видимо линукс версия сильно завязана на этом трее, если он отсутствует в дистрибутиве, то и уведомления работать не будут.
3) Поменять рабочее окружение на `GNOME Xorg` на логине
4) Все сертификаты `VPN` лежат в ~/.cert
