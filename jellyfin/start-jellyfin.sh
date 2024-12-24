docker run -d \
  --name=jellyfin \
  -v ~/jellyfin/config:/config \
  -v ~/jellyfin/cache:/cache \
  -v ~/torrent:/media \
  -p 8096:8096 \
  --restart unless-stopped \
  jellyfin/jellyfin:latest