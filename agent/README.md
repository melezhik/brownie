# How to agent to pool

## Build docker container

Build image

```bash
docker build . -t  agent
```

## Run agent 

Run agent server

```bash
docker run --rm -it --name agent -p 4000:4000 agent
```

Add agent to pool

Go to http://127.0.0.1 

- login admin/admin

- run `agent` project job

# FAQ

> How to change agent name visible in pool

Run agent server with `BRW_AGENT_NAME_PREFIX` variable:

```bash
docker run --rm -it --name agent -p 4000:4000 -e BRW_AGENT_NAME_PREFIX=cool-boy agent
```


