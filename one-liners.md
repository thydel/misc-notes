# Curated bash history

## Dispatch git dirs one level

```bash
p=some; mkdir -p $p; grep -l 'url.*:'$p */.git/config | cut -d/ -f1 | xargs echo mv -t $p.d/
```

## Gather one level dirs

```bash
(d=all.d; mkdir -p $d; cd $d; ls -d ../*.d | grep -v $d | xargs -i find {} -type d -mindepth 1 -maxdepth 1 | xargs -i echo ln -s {})
```
