# Install jq from source on debian stretch

```
sudo aptitude install python3-markdown autoconf libtool flex bison python3-lxml
sudo pip install pipenv

git clone git@github.com:stedolan/jq.git stedolan/jq
ln -s stedolan/jq
cd jq
git submodule update --init
autoreconf -fi
./configure --with-oniguruma=builtin
echo -e '/python build_manpage/s//python3 build_manpage\nwq' | ed Makefile
make -j8
#make test
sudo make install
```
