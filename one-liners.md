**Curated bash history**

May require a `| dash` (or `|bash`) postfix.

# First ssh on a new node

```bash
ssh-copy-id -i ~/.ssh/id_rsa -o PreferredAuthentications=password new
```

# Dispatch git dirs one level

```bash
p=some; mkdir -p $p; grep -l 'url.*:'$p */.git/config | cut -d/ -f1 | xargs echo mv -t $p.d/
```

# Gather one level dirs

```bash
(d=all.d; mkdir -p $d; cd $d; ls -d ../*.d | grep -v $d | xargs -i find {} -type d -mindepth 1 -maxdepth 1 | xargs -i echo ln -s {})
```

# Update dir links time

```bash
find -maxdepth 1 -type l | cut -d/ -f2 | xargs -i echo touch -hr {}/. {}
```

# Sort dirs by size excluding mounted ones

```bash
du -xd1 /dir
```

# sort dirs by file count (mixing first third levels)

```bash
find /dir -type f | awk -F/ -v OFS=/ -v c=cat '{print $2|c; print $2,$3|c; print $2,$3,$4|c}' | sort | uniq -c | sort -nr | awk '$1>1'
```

# How do I find out my python path using python?

[How do I find out my python path using python?]:
	http://stackoverflow.com/questions/1489599/how-do-i-find-out-my-python-path-using-python "stackoverflow"

See [How do I find out my python path using python?][]

```bash
python -c "import sys; print '\n'.join(sys.path)"
```

# Use make for simple parallel transformation on a set of files

```
find -name '*.gz' | rev | cut -d. -f2- | rev | xargs make -f <(echo '%: %.gz; gunzip $<') -j 16
```

# Trust a GPG key non interactively

## With output

```
echo -e 'trust\n5\ny' | gpg --command-fd 0 --edit-key 4AEE18F83AFDEB23
```

## Without output

```
echo -e 'trust\n5\ny' | gpg --command-fd 0 --no-tty --batch --edit-key 4AEE18F83AFDEB23 
```

## Show session

```console
thy@tdeltd:~$ echo 1 | gpg --command-fd 0 --search 4AEE18F83AFDEB23
gpg: data source: http://192.94.109.73:11371
(1)	GitHub (web-flow commit signing) <noreply@github.com>
	  2048 bit RSA key 4AEE18F83AFDEB23, created: 2017-08-16
gpg: key 4AEE18F83AFDEB23: public key "GitHub (web-flow commit signing) <noreply@github.com>" imported
gpg: marginals needed: 3  completes needed: 1  trust model: pgp
gpg: depth: 0  valid:   1  signed:   1  trust: 0-, 0q, 0n, 0m, 0f, 1u
gpg: depth: 1  valid:   1  signed:   0  trust: 1-, 0q, 0n, 0m, 0f, 0u
gpg: Total number processed: 1
gpg:               imported: 1

thy@tdeltd:~$ gpg -k 4AEE18F83AFDEB23
pub   rsa2048 2017-08-16 [SC]
      5DE3E0509C47EA3CF04A42D34AEE18F83AFDEB23
uid           [ unknown] GitHub (web-flow commit signing) <noreply@github.com>

thy@tdeltd:~$ echo -e 'trust\n5\ny' | gpg --command-fd 0 --no-tty --batch --edit-key 4AEE18F83AFDEB23 

thy@tdeltd:~$ gpg -k 4AEE18F83AFDEB23
pub   rsa2048 2017-08-16 [SC]
      5DE3E0509C47EA3CF04A42D34AEE18F83AFDEB23
uid           [ultimate] GitHub (web-flow commit signing) <noreply@github.com>
```
