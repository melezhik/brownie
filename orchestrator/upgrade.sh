set -e

echo "upgrade 010r"
echo "============="
cd /opt/brownie/orchestrator
git pull
bash sync.sh

echo "cleanup o10r queue"
echo "==================="

rm -rf ~/.sparky/projects/brw-orch/.triggers/*

echo "terminate running o10r"
echo "======================"

raku -e '
if "{%*ENV<HOME>}/.sparky/work/brw-orch/.states".IO ~~ :d {
    for dir "{%*ENV<HOME>}/.sparky/work/brw-orch/.states" -> $i {
        next if $i.basename ~~ /[".exit-code" || ".terminate" || ".pid"] $$/;
        next if "{$i.path}.exit-code".IO ~~ :f;
        next if "{$i.path}.terminate".IO ~~ :f;
        say "send termination request as {$i.path}.terminate";
        "{$i.path}.terminate".IO.spurt("");
    }

}
'

echo "start new o10r job"
echo "=================="

cd /root/.sparky/projects/brw-orch/

mkdir -p .triggers

job_id=$(date +%s)

raku -e 'say %( :description<go_go_go> ).raku' > .triggers/$job_id


