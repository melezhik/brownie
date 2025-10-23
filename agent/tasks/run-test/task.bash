module=$(config module)
echo "install $module"
rm -rf log.txt

if zef install $module 1>log.txt 2>&1; then
  echo "installation succeed"
  update_state success 1
 else
  echo "installation failed"
  update_state success 0
fi
