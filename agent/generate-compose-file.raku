#!/usr/bin/env raku

use v6.*;

class ServiceConfig {
  has $.agent-prefix;
  has $.agent-count;

  has $.jobs-per-agent;

  has $.cpus;
  has $.memory;

  has $.fetch-degree;
  has $.test-degree;
}

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

sub gen-services($config, :$volume) {
    my $services = "services:\n";
    $services = $services ~ gen-container($_,  $config, :$volume) for 1..$config.agent-count;
    $services
}

sub gen-container($idx, $config, :$volume) {

    my $degree-yaml =
    qq:to/END/;
          - ZEF_FETCH_DEGREE={$config.fetch-degree}
          - ZEF_TEST_DEGREE={$config.test-degree}
          - BRW_AGENT_NAME_PREFIX={$config.agent-prefix}
          - BRW_AGENT_MAX_THREADS={$config.jobs-per-agent}
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
{$env-yaml.chomp}
        build:
          context: ./
          dockerfile: Dockerfile
        ports:
          - 400{$idx-1}:4000
        deploy:
          resources:
            limits:
              cpus: {$config.cpus}
              memory: {$config.memory}
            reservations:
              cpus: {$config.cpus * 0.75 andthen .Int}
              memory: {$config.memory * 0.75 andthen .Int}

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
  :n(:$agent-count) = 1,
  :j(:$jobs-per-agent) = 7,
  :c(:$cpus) = 4,
  :m(:$memory) = '3.2g',
  :fd(:$fetch-degree) = 5,
  :td(:$test-degree) = 1,
  Bool :v(:$volume) = False
) {
    my $config = ServiceConfig.new:
                  :$agent-prefix,
                  :$agent-count,
                  :$jobs-per-agent,
                  :$cpus,
                  :$memory,
                  :$fetch-degree,
                  :$test-degree;

    my $yaml = "version: '4'\n"
                  ~ gen-volumes($install-path, :$volume)
                  ~ gen-services($config, :$volume);
    say $yaml
}
