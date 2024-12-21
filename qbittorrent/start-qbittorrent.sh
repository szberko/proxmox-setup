docker run -d \
  --name=qbittorrent \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -e WEBUI_PORT=8080 \
  -e TORRENTING_PORT=6881 \
  -p 8080:8080 \
  -p 6881:6881 \
  -p 6881:6881/udp \
  -v ~/qbittorrent/appdata:/config \
  -v ~/torrent:/downloads \
  --restart unless-stopped \
  --net=host \
  lscr.io/linuxserver/qbittorrent:latest
