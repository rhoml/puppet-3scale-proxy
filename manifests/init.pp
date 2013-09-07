# = Class to manage nginx on 3scale proxy
class nginx {
  include nginx::dependencies
  include nginx::install
}
