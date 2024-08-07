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
  dnf check-update
  sudo dnf install code
  ```
- [ya music](https://github.com/cucumber-sp/yandex-music-linux/releases)
- [ya browser](https://browser.yandex.com)
- [easy effects](https://github.com/wwmm/easyeffects)
  ```sh
  flatpak install flathub com.github.wwmm.easyeffects
  ```
- [droidcam](https://www.dev47apps.com/droidcam/linux/)
  ```sh
  dnf install akmod-v4l2loopback
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
