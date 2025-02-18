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

1) Вытащить из бекапов директории
2) Поменять рабочее окружение на `GNOME Xorg` на логине
3) Все сертификаты `VPN` лежат в ~/.cert
