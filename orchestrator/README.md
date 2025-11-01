# How to run orchestrator

If you want to run o10r self hosted

## Build docker container

```bash
docker build . -t  orch-srv
```

## Run server 

Run o10r server

```bash
docker run --rm -it --name orch-srv -p 4000:4000 orch-srv
```

## Setup agents

o10r should have public URL accessible for agents, agents need to set up via [agent/config.raku](https://github.com/melezhik/brownie/blob/main/agent/config.raku) file (require agent rebuild)

## Dashboard

Go to http://127.0.0.1:4000 to see results of tests from agents

# FAQ

> What is o10r

Short and cool name for orchestrator, kudos to @ab5tract

