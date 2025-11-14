
echo "jobs count ..."

for i in $(find ~/.sparky/projects/ -name .triggers |grep agent.job); do ls -p $i| grep -v /  ; done > q.data

cat q.data | wc -l > q.cnt

echo -n "local queue cnt: "
cat q.cnt

ps uax|grep sparky-run |grep "marker=agent.job"|grep -v grep > r.data

cat r.data | wc -l > r.cnt

echo -n "jobs running cnt: "

cat r.cnt

echo "local queue stat"
cat q.data

echo "jobs running stat"
cat r.data
