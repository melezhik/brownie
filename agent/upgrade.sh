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
        next if $i.basename ~~ /[".exit-code" || ".terminate" || ".pid"] $$/;
        next if "{$i.path}.exit-code".IO ~~ :f;
        next if "{$i.path}.terminate".IO ~~ :f;
        say "send termination request as {$i.path}.terminate";
        "{$i.path}.terminate".IO.spurt("");
    }

}
'

echo "start new agent job"
echo "==================="

cd /root/.sparky/projects/agent/

mkdir -p .triggers

job_id=$(date +%s)


raku -e 'say %( :description<go_go_go> ).raku' > .triggers/$job_id


