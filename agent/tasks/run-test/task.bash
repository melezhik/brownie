module=$(config module)

echo "install  l [$module]"

echo ">>>"

echo "install  [$module]" > log.txt

echo "..." >> log.txt

export ZEF_INSTALL_TO=$(config zef_install_to)
export ZEF_FETCH_DEGREE=1
export ZEF_TEST_DEGREE=1
export RAKULIB="inst#$ZEF_INSTALL_TO"

echo "dump env vars" > dump.txt

env | grep ZEF_ >> dump.txt

env | grep RAKULIB >> dump.txt

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
