set -e

echo "upgrade agent"
echo "============="
cd /opt/brownie/agent
git pull
bash sync.sh


echo "terminate running agent"
echo "======================="

raku -e '
if "{%*ENV<HOME>}/.sparky/work/agent/.states".IO ~~ :d {
    for dir "{%*ENV<HOME>}/.sparky/work/agent/.states" -> $i { 
        next if $i.basename ~~ /[".pid" || ".exit-code" || ".terminate"]  $$/; 
        "{$i.path}.terminate".spurt();
        say "send termination request as {$i.path}.terminate"; 
    }
}
'

echo "start new agent job"
echo "==================="

cd /root/.sparky/projects/agent/

mkdir -p .triggers

raku -e 'say %( :description<go_go_go> ).raku' > .triggers/go


