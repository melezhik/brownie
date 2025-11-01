# How to add agent to pool

## Build docker container

```bash
docker build . -t  agent
```

## Run agent 

Run agent server

```bash
docker run --rm -it --name agent -p 4000:4000 agent
```

## Workloads

Once agent is registered in orchestrator, it starts receiving workload and starts execute it, you'll see `agent.job` jobs in agent UI:

http://127.0.0.1:4000

## Orchestrator endpoint

To see test results from other agents go to http://brw.sparrowhub.io

# FAQ

> How to change agent name visible in pool

Run agent server with `BRW_AGENT_NAME_PREFIX` variable:

```bash
docker run --rm -it --name agent -p 4000:4000 -e BRW_AGENT_NAME_PREFIX=cool-boy agent
```

> How to clear agent queue

```bash
docker exec -it agent /bin/bash
rm -rf ~/.sparky/projects/agent.job/.triggers/*
```


