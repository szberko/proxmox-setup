# Guide to passthrough GPU to LXC container

> The guide may be incomplete as I'm writing this retroversly once the setup was done

## Useful links:
- https://kcore.org/2022/02/05/lxc-subuid-subgid/
- https://www.youtube.com/watch?v=0ZDr5h52OOE (*THIS SHOULD BE FOLLOWED*)
- https://xahteiwi.eu/resources/hints-and-kinks/lxc-basics/
- https://www.saninnsalas.com/pass-intel-igpu-to-an-unprivileged-lxc-container-proxmox/

## Steps

On the Proxmox host run the following commands:

```
ls -l /dev/dri # check is the graphic card is available and the drivers are installed. You should see something like "renderD128"
lspci -nnv | grep VGA # list out your VGA(s)
```

Mandatory things:
- edit the `/etc/subgid` file
- add root to `render` and `video` group
- edit the `/etc/pve/lxc/<lxc-id>.conf` file
  - map the gids
  - map the uid (only root)
- 