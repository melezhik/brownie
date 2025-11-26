FROM docker.io/rakudo-star:latest

RUN apt-get update -y && apt-get upgrade -y && apt-get install openssl libssl-dev make gcc -y

RUN zef update && zef install --/test Cro::TLS

RUN zef install --/test Sparrow6

RUN zef install --/test Tomtit 

RUN zef install --/test Sparrowdo

RUN zef install --/test --force-install https://github.com/melezhik/sparky.git

ENV SP6_REPO=https://sparrowhub.io/repo

RUN cd /opt/ && git clone https://github.com/melezhik/sparky.git

RUN cd /opt/sparky && raku db-init.raku

RUN echo "SPARKY_API_TOKEN: blin20" > /root/sparky.yaml

RUN echo 'PATH=$PATH:/usr/share/perl6/core/bin:/usr/share/perl6/site/bin:/usr/share/perl6/vendor/bin' > /root/.bash_profile

RUN apt-get install -y nano less

# required for bindings

RUN apt-get install -y unzip g++ python3 libpam0g-dev libxml2-dev libglib2.0-dev libharfbuzz0b libfreetype-dev libfreetype6 libfreetype6-dev libpq-dev python3-dev libsodium-dev libsodium23 libfann-dev libimage-magick-perl libarchive13 libarchive13 libmp3lame0 libshout3 libogg-dev libvorbis-dev libcairo2-dev libbrotli-dev libsnappy-dev libusb-dev libnotmuch-dev libfreetype6 libgd-dev libgdbm-dev libglfw3 libsdl1.2-dev libgumbo-dev libexif12 libgd-dev libimlib2-dev libperl-dev python3-jupyter-core liblmdb-dev libcurl4 libgit2-dev libyaml-dev libmagickwand-dev libprimesieve-dev libmsgpack-dev libcurl4-openssl-dev libidn11-dev libidn2-dev libzmq3-dev libopencv-dev g++ libsdl1.2-dev libsdl-mixer1.2-dev libsdl-image1.2-dev libssh-dev libssl-dev libtcc-dev golang-toml-dev libtagc0-dev libmarkdown2-dev libtcc-dev libnotify4 fonts-dejavu-core libgtk-3-dev libxml2-dev libxslt-dev libgumbo-dev

RUN zef install --/test Random::Names

RUN cd /opt/sparky && git pull && zef install . --force-install --/test

RUN zef install https://github.com/melezhik/sparky-job-api.git --/test --force-install

RUN echo OK2 && zef install https://github.com/melezhik/sparrow6-rakudo-install.git URI::Encode --/test 

ENTRYPOINT cd /opt/sparky && sparman --base $PWD worker_ui conf &&  sparman worker_ui start  && sparman --env SPARKY_TIMEOUT=10 worker start &&  tail -f ~/.sparky/sparkyd.log

COPY config.raku tasks sparrowfile sparky.yaml /root/.sparky/projects/agent/

COPY tasks /root/.sparky/projects/agent/tasks/

RUN cd /root/.sparky/projects/agent/ && mkdir -p .triggers && raku -e 'say %( :description<go_go_go> ).raku' > .triggers/go

RUN echo OK && cd /opt/sparky && git pull && zef install --/test --force-install .

WORKDIR /app

ENV SP6_FORMAT_COLOR=1

ENV BRW_AGENT_NAME_PREFIX=

ENV ZEF_INSTALL_TO=

ENV ZEF_FETCH_DEGREE=5

ENV ZEF_TEST_DEGREE=1

ENV BRW_AGENT_MAX_THREADS=4

ENV BRW_AGENT_VERSION=0.0.27

ENV BRW_AGENT_CAP_INSTALL_FROM_SOURCE_FORCE=
