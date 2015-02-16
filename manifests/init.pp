# Class: icingaweb2
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
#  include icingaweb2
#
class icingaweb2 inherits icingaweb2::params {

  $base_name = $icingaweb2::params::base_name

  #---

  if ! defined(Group[$icingaweb2::params::group_name]) {
    corl::group { $base_name:
      resources => {
        primary => {
          name   => $icingaweb2::params::group_name,
          ensure => 'present',
          system => true
        }
      }
    }
  }

  #---

  git::repo { $base_name:
    path              => $icingaweb2::params::repo_path,
    user              => $icingaweb2::params::git_user,
    owner             => $icingaweb2::params::git_owner,
    group             => $icingaweb2::params::git_group,
    home_dir          => '',
    source            => $icingaweb2::params::source,
    revision          => $icingaweb2::params::revision,
    base              => false,
    monitor_file_mode => false
  }
}