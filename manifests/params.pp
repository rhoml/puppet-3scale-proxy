# == Class: nginx::params
#
# Params resource for nginx module
#
# === Configuration
#
# [*3scale_id*] => Should be modified depending on your account information at 3scale.
# === Authors
#
# Rhommel Lamas <roml@rhommell.com>
#
# === Copyright
#
# Copyright 2013 Rhommel Lamas.

class nginx::params {
  $3scale_id         = ''
  $openresty_path    = '/opt/openresty'
  $openresty_version = '1.2.3.8'
  $prefix            = '/usr/src'

  if 3scale_id == '' {
    notify('You must set your 3scale_id on nginx::params resource')
  } else {
  $provider_id       = $3scale_id
  }
}
