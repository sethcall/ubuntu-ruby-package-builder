Why the fork?
=============
I wanted a newer version of ruby, but also with --enable-shared specified as a configure flag.

Major differences with the original author's 1.9.3-p125 script are:
* all necessary lib*dev dependencies installed before compilation
* use of libyaml-0-2 instead of compiling yaml from source
* specification of --enable-shared
* tightened up minimum dependecy versions to match an up-to-date Ubuntu 12.04 (on Jan 20, 2013)

Ubuntu Ruby Package Builder
===========================

A few scripts to make it easy to build Ruby .deb packages on Ubuntu.

All scripts require 'fpm' to create the .deb.


### To build a Ruby 2.0.0-p247 package:

    wget -O- -q https://raw.github.com/sethcall/ubuntu-ruby-package-builder/master/build-deb-ruby-2.0.0-p247.sh | sh
    
    
### To build a Ruby 2.0.0-p0 package:

    wget -O- -q https://raw.github.com/sethcall/ubuntu-ruby-package-builder/master/build-deb-ruby-2.0.0-p0.sh | sh
    
    
### To build a Ruby 1.9.3-p327 package:

    wget -O- -q https://raw.github.com/sethcall/ubuntu-ruby-package-builder/master/build-deb-ruby-1.9.3-p327.sh | sh


### To build a Ruby 1.9.3-p125 package:

    wget -O- -q https://raw.github.com/sethcall/ubuntu-ruby-package-builder/master/build-deb-ruby-1.9.3-p125.sh | sh


### To build a Ruby 1.9.2-p290 package:

    wget -O- -q https://raw.github.com/sethcall/ubuntu-ruby-package-builder/master/build-deb-ruby-1.9.2-p290.sh | sh
    
