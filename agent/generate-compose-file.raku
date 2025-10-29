#!/usr/bin/env raku

use v6.*;

class ServiceConfig {
  has $.prefix;
  has $.cpu = 1.0;
  has $.memory = "2.4g";
  has $.fetch-degree = 5;
  has $.test-degree = 1;
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

sub gen-services($config, $count, :$volume) {
    my $services = "services:";
    $services = $services ~ gen-container($config, $_, :$volume) for 1..$count;
    $services
}

sub gen-container($config, $idx, :$volume) {

    my $degree-yaml =
    qq:to/END/;
          - ZEF_FETCH_DEGREE={$config.fetch-degree}
          - ZEF_TEST_DEGREE={$config.test-degree}
          - BRW_AGENT_NAME_PREFIX={$config.prefix}
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
{$env-yaml.chop}
        build:
          context: ./
          dockerfile: Dockerfile
        ports:
          - 400{$idx-1}:4000
        deploy:
          resources:
            limits:
              cpu: {$config.cpu}
              memory: {$config.memory}

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
  :n(:$container-count) = 8,
  :c(:$cpu) = 2,
  :m(:$memory) = '2.4g',
  :fd(:$fetch-degree) = 5,
  :td(:$test-degree) = 1,
  Bool :v(:$volume) = False
) {
    my ServiceConfig $config .= new:
      :prefix($agent-prefix),
      :$cpu,
      :$memory,
      :$fetch-degree,
      :$test-degree;


    my $yaml = "version: '4'\n"
                  ~ gen-volumes($install-path, :$volume)
                  ~ gen-services($config, $container-count, :$volume);
    say $yaml
}
