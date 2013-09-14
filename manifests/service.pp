# == Class: nginx::service
#
# Resource to manage nginx service.
#
# === Examples
#
#  class { nginx::service }
#
#  or
#
#  include nginx::service
#
# === Provides
#
# Service['nginx']
#
# === Authors
#
# Rhommel Lamas <roml@rhommell.com>
#
# === Copyright
#
# Copyright 2013 Rhommel Lamas.
class nginx::service inherits nginx::params {
  service {
    'nginx':
      ensure     => 'running',
      enable     => true,
      pattern    => 'nginx',
      hasstatus  => true,
      hasrestart => true,
      require    => [ File["${nginx::params::openresty_path}/nginx/conf/nginx.conf"], File["${nginx::params::openresty_path}/nginx/conf/nginx_${nginx::params::provider_id}.lua"], File['/etc/init.d/nginx'] ]
  }
}
