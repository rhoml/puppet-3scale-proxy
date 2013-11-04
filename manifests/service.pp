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
class nginx::service (
  $provider_id       = "${nginx::params::provider_id}",
  $openresty_version = "${nginx::params::openresty_version}",
  $prefix            = "${nginx::params::prefix}",
  $openresty_path    = "${nginx::params::openresty_path}"
) inherits nginx::params {
  service {
    'nginx':
      ensure     => 'running',
      enable     => true,
      pattern    => 'nginx',
      hasstatus  => true,
      hasrestart => true,
      require    => [ File["${openresty_path}/nginx/conf/nginx.conf"], File["${openresty_path}/nginx/conf/nginx_${provider_id}.lua"], File['/etc/init.d/nginx'] ]
  }
}
