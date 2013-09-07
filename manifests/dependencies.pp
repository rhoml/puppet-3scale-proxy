# = Class to manage dependencies
class nginx::dependencies {
  case $::operatingsystem {
    Ubuntu,Debian: { require nginx::dependencies::ubuntu }
    default:       { notify('We do not support this OS') }
  }
}
