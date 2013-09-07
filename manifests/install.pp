# = Class to install nginx
class nginx::install (
  $prefix            = '/usr/src',
  $openresty_version = '1.2.3.8'
  ) {

  File {
    owner => 'nginx',
    group => 'nginx',
  }

  # Ensure needed directories Exist
  if ! defined(File[$prefix]) { file { $prefix: ensure => 'directory' } }

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
    "/usr/src/ngx_openresty-${openresty_version}.tar.gz":
      source  => "puppet:///modules/nginx/packages/ngx_openresty-${openresty_version}.tar.gz",
      alias   => 'nginx-source-tgz',
      before  => Exec['untar-nginx-source']
  }

  # Untar the files.
  exec {
    "tar xzf ngx_openresty-${openresty_version}.tar.gz":
      path      => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ],
      cwd       => "${prefix}",
      creates   => "${prefix}/ngx_openresty-${openresty_version}",
      alias     => 'untar-nginx-source',
      subscribe => File['nginx-source-tgz']
  }

  exec {
    "/bin/ls | ./configure --prefix=/opt/openresty --with-luajit --with-http_iconv_module -j2 && touch ${prefix}/ngx_openresty-${openresty_version}/.config":
      path    => [ '/bin/', '/sbin/' ,'/usr/bin/','/usr/sbin/' ],
      cwd     => "${prefix}/ngx_openresty-${openresty_version}",
      require => [ Package['libreadline-dev'], Package['libncurses5-dev'], Package['libpcre3'], Package['libpcre3-dev'], Package['libssl-dev'], Package['perl'], Exec['untar-nginx-source'] ],
      creates => "${prefix}/ngx_openresty-${openresty_version}/.config",
      alias   => 'configure-nginx',
      before  => Exec['make-install']
  }

  exec {
    'make && make install':
      path    => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
      cwd     => "/usr/src/ngx_openresty-${openresty_version}",
      alias   => 'make-install',
      creates => '/opt/openresty/sbin/nginx',
      require => Exec['configure-nginx'],
  }

}
