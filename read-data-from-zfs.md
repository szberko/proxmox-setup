# Read data from ZFS file system

The following guide assumes using Linux OS.

```
# mount ZFS pool with all datasets
sudo zpool import -f <pool_name>

# unmount ZFS pool and all datasets within it
sudo zpool export <pool_name>
sudo zpool export -f <pool_name>
```
