# Proxmox - use local hostname instead of IP address to connect to it

> Source: https://pedja.supurovic.net/proxmox-dhcp-multicast-dns/?lang=lat
> The following text is copied over without modifications from the original article only to preserve it in case if the article is deleted

There is a rule that server machines should always be on static IP. Proxmox is designed in that manner. You are supposed to manually set IP. I am not fond of that approach. Yes, IP should be static, but I prefer to assign IP using DHCP.

Fro some reason Proxmox does not have installed support for Multicast DNS. THat means zou have to access it using IP or assign domain to IP to access it by domain. You cannot use host name to access it using Multicast DNS request. I like to use Multicast DNS.

Dynamic configuration is helpful, when I have to set up device in my localnetwork but them move it to other network where it would be used. Once it cached DHCP it is ready to work.

## Set DHCP
To switch using DHCP you have to do two things, set network interface to DHCP, and set IP in hosts file.

Open `/etc/network/interfaces` in editor (nano is ok) and change settings for interface to use DHCP.

You will find something like this:
```
auto vmbr0
iface vmbr0 inet static
  address 10.0.0.8/24
  gateway 10.0.0.1
  bridge-ports eno1
  bridge-stp off
  bridge-fd 0
```
Change iface from static to dhcp and remove address and gateway. Something liek this:
```
auto vmbr0
iface vmbr0 inet dhcp
  bridge-ports eno1
  bridge-stp off
  bridge-fd 0
```
Now edit hosts file. For some reason, Proxmox insists that host name has proper IP address assigned. So you have to set it in hosts, and it should not use 127.0.0.1 for that purpose:

Edit `/etc/hosts` file to look like this:
```
127.0.0.1 localhost.localdomain localhost
10.0.0.8 proxmox.mydomain.com proxmox
```
The second line is important. Use IP that is assigned to device via DHCP.

Reboot device.

In my experience, it actually does not matter which IP it is as long as it is not 127.0.0.1. It is odd to me. I come from Windows world and in Windows it is perfectly normal to assign local host name or any other domain that is assigned to PC, to use 127.0.0.1. But on Proxmox, if you use 127.0.0.1 there, Proxmox would not be able to run normally – you would not be able to access it using web interface but only directly on console.

On the other hand, I found out that I do not have to sync IP used in `/etc/hosts` with actual IP that is assigned to device. As long as IP in hosts is different from 127.0.0.1 Proxmox works fine. It should not be that way, I have no idea what happens there, but that is how it works for me.

Anyways if you face issue that proxmox services cannot start, first thing you should try is to edit hosts file and set IP to be the same assigned to network interface.

## Multicast DNS
Multicast DNS is great service. It allows accessing device by name in network even if you do not know its IP. All you have to know is its host name. Use hostname.local and that would initiate Multicast DNS broadcast request in local network. Device with requested host name will respond and tell what is it’s IP.Multicast DN is widespread and actually, Proxmox is the only platform I met that does not support it.

Thankfully, it is not hard to add that service, Zou just have to isntall avahi using this command:

```
apt-get install avahi-daemon avahi-dnsconfd avahi-discover avahi-utils
```
Wait for it to finish and reboot.

Now ping device form some PC inlocal network using hostname.local and it should respond.

You may face nuisance. By default Proxmox assigns to itself IPV6 address too and avahi may respond to Multicast DNS with IPV6 address. It does not affect functionality, bit it is odd, if you do not use IPV6 addresses in your network. If you want to force it to use IPV4 the simplest way is to just disable IPV6 on Proxmox.

Edit `/etc/sysctl.conf` adn add this line:

```
net.ipv6.conf.all.disable_ipv6 = 1
```
Reboot. From noon, Proxmox will work with IPV4 addresses only.

## Ending note
I am in no way Proxmox or Linux expert. Actually, I just installed it for the first time. It took some time until I found out how to make this to work so I made this note more to myself, as remainder for later use.

If there is something really wrong with this kind of configuration, please comment. It would help me, and hopefully others to learn.
