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

COPY config.raku tasks sparrowfile sparky.yaml /root/.sparky/projects/agent/

COPY tasks /root/.sparky/projects/agent/tasks/

RUN echo "SPARKY_API_TOKEN: blin20" > /root/sparky.yaml

RUN echo 'PATH=$PATH:/usr/share/perl6/core/bin:/usr/share/perl6/site/bin:/usr/share/perl6/vendor/bin' > /root/.bash_profile

RUN apt-get install -y nano less

# required for bindings

RUN apt-get install -y unzip g++ python3 libpam0g-dev libxml2-dev libglib2.0-dev libharfbuzz0b libfreetype-dev libfreetype6 libfreetype6-dev libpq-dev python3-dev

ENTRYPOINT cd /opt/sparky && sparman --base $PWD worker_ui conf &&  sparman worker_ui start  && sparman worker start &&  tail -f ~/.sparky/sparkyd.log

WORKDIR /app

ENV SP6_FORMAT_COLOR=1

ENV BRW_AGENT_NAME_PREFIX=agent
