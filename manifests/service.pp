# = Class to manage nginx as a service
class nginx::service {
  service {
    'nginx':
      ensure     => 'running',
      hasstatus  => true,
      hasrestart => true,
      enable     => true,
  }
}
