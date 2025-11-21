set -e

version=$(config version)

cd /opt/

test -d /opt/rakudo/.git || git clone --progress https://github.com/rakudo/rakudo.git rakudo

cd rakudo

git checkout $version

git pull

git status

perl Configure.pl --backend=moar --gen-moar --gen-nqp --prefix /tmp/whateverable/rakudo-moar/$version

make

make install

export PATH=/tmp/whateverable/rakudo-moar/$version/bin/:/tmp/whateverable/rakudo-moar/$version/share/perl6/site/bin:$PATH

which raku

raku -v

cd /opt

test -d /opt/zef/.git || git clone https://github.com/ugexe/zef.git

cd zef

unset ZEF_INSTALL_TO

raku -I . bin/zef install . --/test

which zef

zef --version


