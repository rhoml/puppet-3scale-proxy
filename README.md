Puppet module for 3scale proxy [![Build Status](https://travis-ci.org/rhoml/puppet-3scale-proxy.png?branch=master)](https://travis-ci.org/rhoml/puppet-3scale-proxy)
============================

## Requirements

* __STDLIB__: https://github.com/puppetlabs/puppetlabs-stdlib

## Gathering 3scale proxy config files

You can follow the instructions on the support page at 3scale's support [website](https://support.3scale.net/howtos/api-configuration/nginx-proxy).
## Before running the module

After gathering 3scale's configuration, you will download a **proxy_conf.zip** file which you should unzip on the nginx files directory.

## USAGE

### Cloning the repo

````
  cd /path/to/your/puppet/modules
  git clone git@github.com:rhoml/puppet-3scale-proxy-module.git nginx
  cd nginx/files
  unzip /path/to/proxy_conf.zip
````

### Adding the class to your manifests

````
class { 'nginx': }
````

## Author

**Rhommel Lamas**

1. __Twitter__: @rhoml
2. __Email__: roml [at] rhommell.com

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
