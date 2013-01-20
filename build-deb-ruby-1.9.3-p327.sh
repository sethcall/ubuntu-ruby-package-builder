#!/bin/sh

version=1.9.3
patch=p327
rubyversion=$version-$patch
rubysrc=ruby-$rubyversion.tar.bz2
checksum=7d602aba93f31ceef32800999855fbca
destdir=/tmp/install-$rubyversion

sudo apt-get -y install libssl-dev libreadline-dev zlib1g-dev

if [ ! -f yaml-0.1.4.tar.gz ]; then
  wget -q http://pyyaml.org/download/libyaml/yaml-0.1.4.tar.gz
fi

tar xzvf yaml-0.1.4.tar.gz
cd yaml-0.1.4
./configure --prefix=/usr/local && make && make install DESTDIR=$destdir
cd ..

if [ ! -f $rubysrc ]; then
  wget -q ftp://ftp.ruby-lang.org/pub/ruby/1.9/$rubysrc
fi

if [ "$(md5sum $rubysrc | cut -b1-32)" != "$checksum" ]; then
  echo "Checksum mismatch!"
  exit 1
fi

echo "Unpacking $rubysrc"
tar -jxf $rubysrc
cd ruby-$rubyversion
./configure --prefix=/usr/local --disable-install-doc --with-opt-dir=/tmp/$destdir/usr/local --enable-shared && make && make install DESTDIR=$destdir

cd ..
gem list -i fpm || sudo gem install fpm
fpm -s dir -t deb -n ruby$version -v $rubyversion -C $destdir \
  -p ruby-VERSION_ARCH.deb -d "libstdc++6 (>= 4.4.3)" \
  -d "libc6 (>= 2.6)" -d "libffi6 (>= 3.0.10)" -d "libgdbm3 (>= 1.8.3)" \
  -d "libncurses5 (>= 5.7)" -d "libreadline6 (>= 6.1)" \
  -d "libssl1.0.0 (>= 1.0.1)" -d "zlib1g (>= 1:1.2.2)" \
  usr/local/bin usr/local/lib usr/local/share/man usr/local/include

rm -r $destdir
