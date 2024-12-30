# Read data from ZFS file system

The following guide assumes using Linux OS.

```
# mount ZFS pool with all datasets
sudo zpool import <pool_name> # default mount point location is /<pool_name>
sudo zpool import -R <custom mountpoint> <pool_name>
sudo zpool import -f <pool_name> # force import

# unmount ZFS pool and all datasets within it
sudo zpool export <pool_name>
sudo zpool export -f <pool_name> # force export (unmount, disconnect)
```
