docker run -d \
  --name=transmission \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -p 9091:9091 \
  -p 51413:51413 \
  -p 51413:51413/udp \
  -v ~/transmission/data:/config \
  -v ~/torrent:/downloads \
  --restart unless-stopped \
  lscr.io/linuxserver/transmission:latest
