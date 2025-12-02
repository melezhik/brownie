set -e

echo "start test"

module=$(config module)

rakudo_version=$(config rakudo_version)

old_path=$PATH

export PATH=/tmp/whateverable/rakudo-moar/$rakudo_version/bin/:/tmp/whateverable/rakudo-moar/$rakudo_version/share/perl6/site/bin:$PATH

echo "[raku]" > log.txt

which raku >> log.txt

raku --version >> log.txt

echo "[zef]" >> log.txt

which zef >> log.txt

zef --version >> log.txt

echo "===" >> log.txt

echo "zef test $module" >> log.txt

if ! test  "${zef_install_to}" = ""; then
  #echo "zef_install_to is set to $zef_install_to, apply it"
  export ZEF_INSTALL_TO=$zef_install_to
  export RAKULIB="inst#$ZEF_INSTALL_TO"
else
  #echo "zef_install_to is empty, using standard zef path for install"
  unset ZEF_INSTALL_TO
fi

zef test $module 1>>log.txt 2>&1 || :

echo "test log"

echo "========"

cat log.txt


