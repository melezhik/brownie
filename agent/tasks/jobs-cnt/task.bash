
echo "jobs count ..."

for i in $(find ~/.sparky/projects/ -name .triggers |grep agent.job); do ls -p $i| grep -v /  ; done | \
wc -l > q.cnt


cat q.cnt

ps uax|grep sparky-run |grep "marker=agent.job"|grep -v grep| wc -l > r.cnt


cat r.cnt
