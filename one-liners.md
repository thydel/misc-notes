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
