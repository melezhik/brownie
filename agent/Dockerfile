FROM docker.io/rakudo-star:latest

RUN apt-get update -y && apt-get upgrade -y && apt-get install openssl libssl-dev make gcc -y

RUN zef install --/test Cro::TLS

RUN zef install --/test Sparrow6

RUN zef install --/test Tomtit 

RUN zef install --/test Sparrowdo

RUN zef install --/test --force-install https://github.com/melezhik/sparky.git

ENV SP6_REPO=https://sparrowhub.io/repo

RUN cd /opt/ && git clone https://github.com/melezhik/sparky.git

RUN cd /opt/sparky && raku db-init.raku

ENTRYPOINT cd /opt/sparky && sparman --base $PWD worker_ui conf &&  sparman worker_ui start  && sparman worker start &&  tail -f ~/.sparky/sparkyd.log 

WORKDIR /app

ENV SP6_FORMAT_COLOR=1

ENV BRW_AGENT_NAME_PREFIX=agent