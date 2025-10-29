module=$(config module)

echo "install [$module]"

echo ">>>"

echo "install [$module]" > log.txt

echo "..." >> log.txt

zef_install_to=$(config zef_install_to)

if ! test  "{$zef_install_to}" = ""; then
  echo "zef_install_to is set to $zef_install_to, apply it"
  export ZEF_INSTALL_TO=$zef_install_to
  export RAKULIB="inst#$ZEF_INSTALL_TO"
else
  echo "zef_install_to is empty, using standard zef path for install"
fi


export ZEF_FETCH_DEGREE=$(config zef_fetch_degree)

export ZEF_TEST_DEGREE=$(config zef_test_degree)

echo "dump env vars" > dump.txt

env | grep ZEF_ >> dump.txt

env | grep RAKULIB || : >> dump.txt

cat dump.txt

if zef install $module 1>>log.txt 2>&1; then
  echo "installation succeed"
  update_state success 1
 else
  echo "installation failed"
  update_state success 0
fi

echo "test log"

echo "========"

cat log.txt

cp log.txt log2.txt

mv dump.txt log.txt

cat log2.txt >> log.txt

rm -rf log2.txt
