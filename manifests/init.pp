# Class: icinga2web
#
#   This module configures the Icinga2 web environment.
#
#   Adrian Webb <adrian.webb@coraltech.net>
#   2015-02-07
#
#   Tested platforms:
#    - Ubuntu 14.04
#
# Parameters:
#
#
# Actions:
#
#   Configures the Icinga2 web environment.
#
#
# Requires:
#
# Sample Usage:
#
#  include icinga2web
#
class icinga2web inherits icinga2web::params {

  $base_name = $icinga2web::params::base_name

  #---

  if ! defined(Group[$icinga2web::params::group_name]) {
    corl::group { $base_name:
      resources => {
        primary => {
          name   => $icinga2web::params::group_name,
          ensure => 'present',
          system => true
        }
      }
    }
  }

  #---

  git::repo { $base_name:
    path              => $icinga2web::params::repo_path,
    user              => $icinga2web::params::user,
    owner             => $icinga2web::params::owner,
    group             => $icinga2web::params::group,
    home_dir          => undef,
    source            => $icinga2web::params::source,
    revision          => $icinga2web::params::revision,
    base              => false,
    monitor_file_mode => false
  }
}