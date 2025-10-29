#!/usr/bin/env raku

use v6.*;

sub gen-volumes($path, Bool :$volume) {
    unless $volume {
      return ''
    }

    die "Installation path required when --volumes is set" unless $path;

    qq:to/END/;
    volumes:
      zef-install:
      driver: local
        driver_opts:
          type: 'none'
          o: 'bind'
          device: '$path'
          name: 'zef-install'

    END
}

sub gen-services($prefix, $count, $cpus, $mem, $degree, :$volume) {
    my $services = "services:";
    $services = $services ~ gen-container($prefix, $_,  $cpus, $mem, $degree, :$volume) for 1..$count;
    $services
}

sub gen-container($prefix, $idx, $cpus, $mem, $degree, :$volume) {

    my $degree-yaml =
    qq:to/END/;
          - ZEF_FETCH_DEGREE=$degree
          - ZEF_TEST_DEGREE=$degree
          - BRW_AGENT_NAME_PREFIX=$prefix
    END

    my $env-yaml = $volume
    ?? do {
        qq:to/END/;
              - ZEF_INSTALL_TO=/zef-install
        $degree-yaml
        END
    } !! $degree-yaml;


    my $yaml = qq:to/END/;
      sparky-agent-$idx:
        environment:
$env-yaml
        build:
          context: ./
          dockerfile: Dockerfile
        ports:
          - 400{$idx-1}:4000
        cpus: $cpus
        memory: $mem

    END

    my $vol-yaml = q:to/END/;
        volumes:
          - type: volume
            source: zef-install
            target: /zef-install

    END

    $volume ?? $yaml ~ $vol-yaml !! $yaml
}


sub MAIN(
  :p(:$install-path),
  :a(:$agent-prefix) = "secret-agent",
  :n(:$container-count) = 4,
  :c(:$cpus) = 4,
  :m(:$memory) = '3.2g',
  :d(:$degree) = $cpus,
  Bool :v(:$volume) = False
) {
    my $yaml = "version: '3'\n"
                  ~ gen-volumes($install-path, :$volume)
                  ~ gen-services($agent-prefix, $container-count, $cpus, $memory, $degree, :$volume);
    say $yaml
}
