module=$(config module)
echo "install $module"
rm -rf log.txt

export ZEF_INSTALL_TO=$(config zef_install_to)


if zef install $module 1>log.txt 2>&1; then
  echo "installation succeed"
  update_state success 1
 else
  echo "installation failed"
  update_state success 0
fi
