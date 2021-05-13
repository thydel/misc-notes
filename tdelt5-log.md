# 2021-05-13

WTF!

```
May 13 14:26:48 tdelt5 NetworkManager[1028]: <warn>  [1620908808.8878] device (wlp2s0): No agents were available for this request.
```

- [Failed to request VPN secrets #3][]

```bash
sudo aptitude install network-manager-openconnect-gnome
systemctl restart NetworkManager
```

NOP

- [[How to Install and Configure Nmcli][]

```bash
nmcli --ask connection up SFR_1A40 ifname wlp2s0
nmcli --ask connection up SFR_1A40_5GHZ ifname wlp2s0
nmcli --ask connection up TP-Link_DF4C ifname wlp2s0
nmcli --ask connection up TP-Link_DF4C_5G ifname wlp2s0
```

YEP

[Failed to request VPN secrets #3]:
	https://unix.stackexchange.com/questions/315235/failed-to-request-vpn-secrets-3
	"unix.stackexchange.com"

[How to Install and Configure Nmcli]:
	https://www.liquidweb.com/kb/how-to-install-and-configure-nmcli/
	"liquidweb.com"
