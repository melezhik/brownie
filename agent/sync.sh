set -e
echo "sync agent"
echo "==="
mkdir -p  ~/.sparky/projects/agent/
cp -r config.raku sparky.yaml sparrowfile tasks/ version  ~/.sparky/projects/agent/
