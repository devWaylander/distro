## Ubuntu
### Soft
- [obsidian](obsidian.sh)
- [antaressql](antaressql.sh)
- [vscode](vscode.sh)
- [ya music](ya-music.sh)
- [ya browser](ya-browser.sh)
- [easy effects](easy-effects.sh)
- [obs](obs.sh)
- [droidcam](droidcam.sh)
- [pano](pano.sh)
- [discord](discord.sh)
- [vk teams](vkteams.sh)
- [telegram](telegram.sh)
- [openrgb](openrgb.sh)
- [vlc](vlc.sh)

### Dev Dependencies
- [go](go.sh)
- [go update](go-update.sh)
- [nvm](nvm.sh)
- [docker](docker.sh)
  
### Common

Дебаг в докере:
```sh
docker build -f .dockerfile -t debug-scripts .
```
```sh
docker run --rm --privileged --mount type=bind,source=/run/dbus/system_bus_socket,target=/run/dbus/system_bus_socket debug-scripts
```

1) Установить `Gnome Extension Manager`
   
   Найти в нём плагин `AppIndicator and KStatusNotifierItem Support` и установить его. Починятся уведомления от VK Teams + наконец-то запашут иконки трея. Видимо линукс версия сильно завязана на этом трее, если он отсутствует в дистрибутиве, то и уведомления работать не будут.
3) Поменять рабочее окружение на `GNOME Xorg` на логине
4) Все сертификаты `VPN` лежат в ~/.cert
