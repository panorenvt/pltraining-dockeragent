# Create and run a Docker containerized Puppet Agent
define dockeragent::node (
  $ports = undef,
) {
  require dockeragent

  docker::run { $title:
    hostname         => $title,
    image            => 'agent',
    command          => '/usr/lib/systemd/systemd',
    ports            => $ports,
    volumes          => $dockeragent::container_volumes,
    extra_parameters => [
      "--add-host \"${::fqdn} puppet:${::ipaddress_docker0}\"",
      '--restart=always',
    ],
  }
}
