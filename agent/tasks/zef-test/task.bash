set -e

echo "start detailed report"

module=$(config module)

rakudo_version=$(config rakudo_version)

agent=$(config agent)

directory=$(config directory)

cd $directory

old_path=$PATH

export PATH=/tmp/whateverable/rakudo-moar/$rakudo_version/bin/:/tmp/whateverable/rakudo-moar/$rakudo_version/share/perl6/site/bin:$PATH

echo "run prove6 verbose for $module" > report.txt 

echo "[agent]" >> report.txt 

echo $agent >> report.txt

echo "[raku]" >> report.txt

which raku >> report.txt

raku --version >> report.txt

echo "[zef]" >> report.txt

which zef >> report.txt

zef --version >> report.txt

echo "===" >> report.txt

echo "zef install . --verbose" >> report.txt

if ! test  "${zef_install_to}" = ""; then
  #echo "zef_install_to is set to $zef_install_to, apply it"
  export ZEF_INSTALL_TO=$zef_install_to
  export RAKULIB="inst#$ZEF_INSTALL_TO"
else
  #echo "zef_install_to is empty, using standard zef path for install"
  unset ZEF_INSTALL_TO
fi

if echo "1) install $module dependencies" >> report.txt && zef install . --deps-only 1>>report.txt 2>&1 && echo -e "2) prove6 -v t/" >> report.txt &&  prove6 -I lib -v t/ 1>>report.txt 2>&1; then
  export PATH=$old_path
  update_state success 1
 else
  export PATH=$old_path
  update_state success 0
fi

echo "report"

echo "========"

cat report.txt


