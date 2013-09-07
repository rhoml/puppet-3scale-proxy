# = Class to manage ubuntu and debian packages
class nginx::dependencies::ubuntu {
  if ! defined(Package['build-essential']) { package { 'build-essential': ensure => 'installed', provider => 'aptitude' } }
  if ! defined(Package['libreadline-dev']) { package { 'libreadline-dev': ensure => 'installed', provider => 'aptitude' } }
  if ! defined(Package['libncurses5-dev']) { package { 'libncurses5-dev': ensure => 'installed', provider => 'aptitude' } }
  if ! defined(Package['libpcre3']) {        package { 'libpcre3':        ensure => 'installed', provider => 'aptitude' } }
  if ! defined(Package['libpcre3-dev']) {    package { 'libpcre3-dev':    ensure => 'installed', provider => 'aptitude' } }
  if ! defined(Package['libssl-dev']) {      package { 'libssl-dev':      ensure => 'installed', provider => 'aptitude' } }
  if ! defined(Package['perl']) {            package { 'perl':            ensure => 'installed', provider => 'aptitude' } }
}
