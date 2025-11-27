set -e

echo "upgrade agent"
echo "============="
cd /opt/brownie/agent
git pull
bash sync.sh

# TBD - terminate running project 

echo "start agent main job"
echo "===================="

cd /root/.sparky/projects/agent/
mkdir -p .triggers
raku -e 'say %( :description<go_go_go> ).raku' > .triggers/go


