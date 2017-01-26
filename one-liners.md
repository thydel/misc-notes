# Curated bash history

Usually need a `| dash` (or `|bash`) postfix.

## Dispatch git dirs one level

```bash
p=some; mkdir -p $p; grep -l 'url.*:'$p */.git/config | cut -d/ -f1 | xargs echo mv -t $p.d/
```

## Gather one level dirs

```bash
(d=all.d; mkdir -p $d; cd $d; ls -d ../*.d | grep -v $d | xargs -i find {} -type d -mindepth 1 -maxdepth 1 | xargs -i echo ln -s {})
```

## Update dir links time

```
find -maxdepth 1 -type l | cut -d/ -f2 | xargs -i echo touch -hr {}/. {}
```
