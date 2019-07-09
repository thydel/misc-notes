# Mitigate SKS Keyserver poisoning

See [SKS Keyserver Network Under Attack][] and [keys.openpgp.org][]

```
time gpg --list-keys # took minutes
time gpg --delete-key EF6E286DDA85EA2A4BA7DE684E2C6E8793298290 # took minutes to delete <torbrowser@torproject.org>
time gpg --list-keys # milliseconds
echo keyserver hkps://keys.openpgp.org > ~/.gnupg/dirmngr.conf
pkill dirmngr
gpg --refresh-keys
gpg --export t.delamare@laposte.net | curl -T - https://keys.openpgp.org
# use stdout URL to require email for nominal ID
# use URL received by email to confirm request
gpg --search-keys t.delamare@laposte.net
gpg --search-keys t.delamare@epiconcept.fr
gpg --refresh-keys
```

[SKS Keyserver Network Under Attack]: https://gist.github.com/rjhansen/67ab921ffb4084c865b3618d6955275f "github.com gist"

[keys.openpgp.org]: https://keys.openpgp.org/about "keys.openpgp.org"

# Maybe useful

- [OpenPGP Certificate Flooding][]
- [CVE-2019-13050][]
- [OpenPGP Best Practices][]

[OpenPGP Certificate Flooding]: https://dkg.fifthhorseman.net/blog/openpgp-certificate-flooding.html "fifthhorseman.net"
[CVE-2019-13050]: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13050 "cve.mitre.org"
[OpenPGP Best Practices]: https://riseup.net/en/security/message-security/openpgp/best-practices "riseup.net"
