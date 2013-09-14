# == Class: nginx::install
#
# This module ensures that Nginx is properly installed, with openresty and Lua.
#
# === Examples
#
#  class { 'nginx::install': }
#
#  or
#
#  include nginx::install
#
# === Authors
#
# Rhommel Lamas <roml@rhommell.com>
#
# === Copyright
#
# Copyright 2013 Rhommel Lamas.
class nginx::install inherits nginx::params {

  File {
    owner => 'nginx',
    group => 'nginx',
  }

  # Ensures needed directories exist
  if ! defined(File["${nginx::params::prefix}"]) {
    file {
      "${nginx::params::prefix}":
        ensure => 'directory',
        owner  => 'root',
        group  => 'root',
        mode   => '0755'
    }
  }

  # Ensure User/group Nginx exists as a system user
  group { 'nginx': gid  =>  1200 }

  user {
    'nginx':
      ensure     => 'present',
      comment    => 'Nginx system user',
      uid        => '1200',
      gid        => '1200',
      shell      => '/bin/false',
      groups     => 'nginx',
      system     => true,
  }

  # Ensure we have the needed Nginx and dependencies packages
  file {
    "/usr/src/ngx_openresty-${nginx::params::openresty_version}.tar.gz":
      source  => "puppet:///modules/nginx/packages/ngx_openresty-${nginx::params::openresty_version}.tar.gz",
      alias   => 'nginx-source-tgz',
      before  => Exec['untar-nginx-source']
  }

  # Untar the files.
  exec {
    "tar xzf ngx_openresty-${nginx::params::openresty_version}.tar.gz":
      path      => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ],
      cwd       => "${nginx::params::prefix}",
      creates   => "${nginx::params::prefix}/ngx_openresty-${nginx::params::openresty_version}",
      alias     => 'untar-nginx-source',
      subscribe => File['nginx-source-tgz']
  }

  # Configure nginx with needed options --with-luajit is required.
  exec {
    "/bin/ls | ./configure --prefix=${nginx::params::openresty_path} --with-luajit --with-http_iconv_module -j2 && touch ${nginx::params::prefix}/ngx_openresty-${nginx::params::openresty_version}/.config":
      path    => [ '/bin/', '/sbin/' ,'/usr/bin/','/usr/sbin/' ],
      cwd     => "${nginx::params::prefix}/ngx_openresty-${nginx::params::openresty_version}",
      require => [ Package['libreadline-dev'], Package['libncurses5-dev'], Package['libpcre3'], Package['libpcre3-dev'], Package['libssl-dev'], Package['perl'], Exec['untar-nginx-source'] ],
      creates => "${nginx::params::prefix}/ngx_openresty-${nginx::params::openresty_version}/.config",
      alias   => 'configure-nginx',
      before  => Exec['make-install']
  }

  exec {
    'make && make install':
      path    => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
      cwd     => "/usr/src/ngx_openresty-${nginx::params::openresty_version}",
      alias   => 'make-install',
      creates => '/opt/openresty/nginx/sbin/nginx',
      require => Exec['configure-nginx']
  }
}
