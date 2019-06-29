## show process tree

pstree -aps <pid>

## ps show ppid

ps -ef

https://unix.stackexchange.com/questions/237214/how-to-get-ppid-with-ps-aux-under-aix

## `ps aux` v.s. `ps -ef`

## ps show thread id (SPID)

```
ps -eT
```

## Logrotate immediately

```
logrotate --force /etc/logrotate.d/some-file
```

## Create a new partition and format with ext4

```
# Suppose a new device is /dev/sdb
sudo fdisk /dev/sdb
sudo mkfs.ext4 /dev/sdb1
```