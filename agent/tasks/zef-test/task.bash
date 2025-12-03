set -e

echo "start test"

module=$(config module)

rakudo_version=$(config rakudo_version)

old_path=$PATH

export PATH=/tmp/whateverable/rakudo-moar/$rakudo_version/bin/:/tmp/whateverable/rakudo-moar/$rakudo_version/share/perl6/site/bin:$PATH

echo "[raku]" > report.txt

which raku >> report.txt

raku --version >> report.txt

echo "[zef]" >> report.txt

which zef >> report.txt

zef --version >> report.txt

echo "===" >> report.txt

echo "zef install $module --/deps --verbose" >> report.txt

if ! test  "${zef_install_to}" = ""; then
  #echo "zef_install_to is set to $zef_install_to, apply it"
  export ZEF_INSTALL_TO=$zef_install_to
  export RAKULIB="inst#$ZEF_INSTALL_TO"
else
  #echo "zef_install_to is empty, using standard zef path for install"
  unset ZEF_INSTALL_TO
fi

zef test $module 1>>report.txt 2>&1 || :

echo "report"

echo "========"

cat report.txt


