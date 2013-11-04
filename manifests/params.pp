# == Class: nginx::params
#
# Params resource for nginx module
#
# === Configuration
#
# [*provider_id*] => Should be modified depending on your account information at 3scale.
# === Authors
#
# Rhommel Lamas <roml@rhommell.com>
#
# === Copyright
#
# Copyright 2013 Rhommel Lamas.

class nginx::params {
  $provider_id       = '48'
  $openresty_path    = '/opt/openresty'
  $openresty_version = '1.2.3.8'
  $prefix            = '/usr/src'
}
