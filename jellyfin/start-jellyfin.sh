docker run \
  -d \
  -v ~/jellyfin/config:/config \
  -v ~/jellyfin/cache:/cache \
  -v ~/torrent:/media \
  -p 8096:8096 \
  -n jellyfin-proxmox \
  jellyfin/jellyfin:latest