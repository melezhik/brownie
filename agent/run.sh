docker build . -t  agent
docker stop -t 1 agent
#docker stop -t 1 agent2

sleep 3

docker run -d --rm --name agent -e BRW_AGENT_MAX_THREADS=3 -p 4002:4000 agent

#docker run -d --rm --name agent2 -p 4003:4000 agent
