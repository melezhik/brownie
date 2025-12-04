module=$(config module)

rakudo_version=$(config rakudo_version)

zef_install_to=$(config zef_install_to)

export ZEF_FETCH_DEGREE=$(config zef_fetch_degree)

export ZEF_TEST_DEGREE=$(config zef_test_degree)

old_path=$PATH

export PATH=/tmp/whateverable/rakudo-moar/$rakudo_version/bin/:/tmp/whateverable/rakudo-moar/$rakudo_version/share/perl6/site/bin:$PATH

echo "==="

echo "[raku]"

which raku

raku --version

echo "[zef]"

which zef

zef --version

echo "==="

echo "install [$module]"

echo "[raku]" > log.txt

which raku >> log.txt

raku --version >> log.txt

echo "[zef]" >> log.txt

which zef >> log.txt

zef --version >> log.txt

echo "===" >> log.txt

echo "install [$module]" >> log.txt

if ! test  "${zef_install_to}" = ""; then
  echo "zef_install_to is set to $zef_install_to, apply it"
  export ZEF_INSTALL_TO=$zef_install_to
  export RAKULIB="inst#$ZEF_INSTALL_TO"
else
  echo "zef_install_to is empty, using standard zef path for install"
  unset ZEF_INSTALL_TO
fi

echo "[env vars]" > dump.txt

env | grep ZEF_ >> dump.txt || :

env | grep RAKULIB >> dump.txt || :

cat dump.txt

if echo -e "1) install $module dependencies\n" >> log.txt && zef install $module --deps-only 1>>log.txt 2>&1 && echo -e "2) install $module\n" >> log.txt && zef install $module 1>>log.txt 2>&1; then
  export PATH=$old_path
  update_state success 1
 else
  export PATH=$old_path
  update_state success 0
fi

echo "test log"

echo "========"

cat log.txt

cp log.txt log2.txt

mv dump.txt log.txt

cat log2.txt >> log.txt

rm -rf log2.txt
