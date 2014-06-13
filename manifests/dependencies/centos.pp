# = Class to manage ubuntu and debian packages
class nginx::dependencies::centos {
  if ! defined(Package['readline-devel']) { package { 'readline-devel':  ensure => 'installed', provider => 'yum' } }
  if ! defined(Package['ncurses-devel']) {  package { 'ncurses-devel':   ensure => 'installed', provider => 'yum' } }
  if ! defined(Package['pcre-devel']) {     package { 'pcre-devel':      ensure => 'installed', provider => 'yum' } }
  if ! defined(Package['pcre']) {           package { 'pcre':            ensure => 'installed', provider => 'yum' } }
  if ! defined(Package['openssl']) {        package { 'openssl':         ensure => 'installed', provider => 'yum' } }
  if ! defined(Package['gcc']) {            package { 'gcc':             ensure => 'installed', provider => 'yum' } }
  if ! defined(Package['zlib-devel']) {     package { 'zlib-devel':      ensure => 'installed', provider => 'yum' } }
}
