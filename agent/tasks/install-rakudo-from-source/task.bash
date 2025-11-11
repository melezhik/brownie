set -e

version=$(config version)

git clone https://github.com/rakudo/rakudo.git rakudo
cd rakudo
git checkout $version
perl Configure.pl --backend=moar --gen-moar --gen-nqp --prefix /tmp/whateverable/rakudo-moar/$version
make
make install

export PATH=/tmp/whateverable/rakudo-moar/$version/bin:$PATH

raku -v

git clone https://github.com/ugexe/zef.git

cd zef

raku -I . bin/zef install . --/test



