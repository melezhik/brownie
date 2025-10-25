docker build . -t  brw-srv
docker stop -t 1 brw-srv
sleep 3
docker run -d --rm --name brw-srv -p 4001:4000 brw-srv
