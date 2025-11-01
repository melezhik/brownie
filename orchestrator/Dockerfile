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

RUN echo "SPARKY_API_TOKEN: blin20" > /root/sparky.yaml

RUN echo 'PATH=$PATH:/usr/share/perl6/core/bin:/usr/share/perl6/site/bin:/usr/share/perl6/vendor/bin' > /root/.bash_profile

RUN apt-get install -y less nano

# PDF and friends

RUN apt-get install -y pkg-config libfreetype6-dev

RUN zef install --/test Random::Names Ecosystem

RUN zef install https://github.com/melezhik/sparky.git --/test --force-install

RUN zef install https://github.com/melezhik/sparky-job-api.git --/test --force-install

ENTRYPOINT cd /opt/sparky && sparman --base $PWD worker_ui conf &&  sparman worker_ui start  && sparman worker start &&  tail -f ~/.sparky/sparkyd.log

COPY config.raku sparrowfile sparky.yaml /root/.sparky/projects/brw-orch/

RUN cd /root/.sparky/projects/brw-orch/ && mkdir -p .triggers && raku -e 'say %( :description<go_go_go> ).raku' > .triggers/go

WORKDIR /app

ENV SP6_FORMAT_COLOR=1
