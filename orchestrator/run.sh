docker build . -t  brw-orch
docker stop -t 1 brw-orch
docker run -d --rm --name brw-orch -p 4002:4000 brw-orch
