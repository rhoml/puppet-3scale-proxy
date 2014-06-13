# = Class to manage dependencies
class nginx::dependencies {
  case $::operatingsystem {
    Ubuntu,Debian: { require nginx::dependencies::ubuntu }
    CentOS,redhat: { require nginx::dependencies::centos }
  }
}
