# My home link just failed

During a telecommute day

# Use my dedicated 4G link

Rather easy since I have a flexible `ssh-config` making heavy use of `Match` and `Proxyjump`

Add some *dest*-via-*bastion* to my `/etc/local/where` (because my 4G
link IP is not in allowed list on some *dest*)

But, that means I must access via wifi instead of eth which require an additional step

```
ip route del default via $LANGW
```
