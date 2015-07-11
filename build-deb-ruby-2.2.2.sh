#!/bin/sh

version=2.2.2
rubyversion=$version
rubysrc=ruby-$version.tar.bz2
checksum=af6eb4fa7247f1f7b2e19c8e6f3e3145
destdir=/tmp/install-$rubyversion

sudo apt-get -y install curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev libffi-dev

if [ ! -f $rubysrc ]; then
    wget -q ftp://ftp.ruby-lang.org/pub/ruby/2.2/$rubysrc
fi

if [ "$(md5sum $rubysrc | cut -b1-32)" != "$checksum" ]; then
  echo "Checksum mismatch!"
  exit 1
fi

echo "Unpacking $rubysrc"
tar -jxf $rubysrc
cd ruby-$rubyversion
./configure --prefix=/usr/local --disable-install-doc --enable-shared && make && make install DESTDIR=$destdir

cd ..
gem list -i fpm || sudo gem install fpm
fpm -s dir -t deb -n ruby$version -v $rubyversion -C $destdir \
  -p ruby-VERSION_ARCH.deb -d "libstdc++6" \
  -d "libc6" -d "libffi6" -d "libgdbm3" \
  -d "libncurses5" -d "libreadline6" \
  -d "libssl1.0.0" -d "zlib1g" \
  -d "libyaml-0-2" \
  usr/local/bin usr/local/lib usr/local/share/man usr/local/include

rm -r $destdir
