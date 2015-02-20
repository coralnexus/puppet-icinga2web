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
    path              => $icingaweb2::params::repo_dir,
    user              => $icingaweb2::params::git_user,
    owner             => $icingaweb2::params::git_owner,
    group             => $icingaweb2::params::git_group,
    home_dir          => '',
    source            => $icingaweb2::params::source,
    revision          => $icingaweb2::params::revision,
    base              => false,
    monitor_file_mode => false
  }

  #---

  corl::file { "${base_name}_dir":
    resources => {
      config => {
        path   => $icingaweb2::params::config_dir
      },
      modules => {
        path    => "${icingaweb2::params::config_dir}/modules",
        require => 'config'
      },
      monitoring => {
        path    => "${icingaweb2::params::config_dir}/modules/monitoring",
        require => 'modules'
      },
      enabled_modules => {
        path    => "${icingaweb2::params::config_dir}/enabledModules",
        require => 'config'
      },
      enabled_monitoring => {
        path    => "${icingaweb2::params::config_dir}/enabledModules/monitoring",
        ensure  => link,
        target  => "${icingaweb2::params::repo_dir}/modules/monitoring",
        require => [ 'enabled_modules', Git::Repo[$base_name] ]
      },
      enabled_docs => {
        path    => "${icingaweb2::params::config_dir}/enabledModules/doc",
        ensure  => link,
        target  => "${icingaweb2::params::repo_dir}/modules/doc",
        require => [ 'enabled_modules', Git::Repo[$base_name] ]
      }
    },
    defaults => {
      ensure => directory,
      owner  => $icingaweb2::params::config_owner,
      group  => $icingaweb2::params::config_group,
      mode   => 0750
    }
  }

  #---

  corl::file { "${base_name}_file":
    resources => {
      authentication => {
        path    => "${icingaweb2::params::config_dir}/authentication.ini",
        content => $icingaweb2::params::auth_config
      },
      config => {
        path    => "${icingaweb2::params::config_dir}/config.ini",
        content => $icingaweb2::params::config_config
      },
      permissions => {
        path    => "${icingaweb2::params::config_dir}/permissions.ini",
        content => $icingaweb2::params::perm_config
      },
      resources => {
        path    => "${icingaweb2::params::config_dir}/resources.ini",
        content => $icingaweb2::params::resource_config
      },
      monitoring_backends => {
        path    => "${icingaweb2::params::config_dir}/modules/monitoring/backends.ini",
        content => $icingaweb2::params::monitoring_backend_config
      },
      monitoring_config => {
        path    => "${icingaweb2::params::config_dir}/modules/monitoring/config.ini",
        content => $icingaweb2::params::monitoring_config_config
      },
      monitoring_instances => {
        path    => "${icingaweb2::params::config_dir}/modules/monitoring/instances.ini",
        content => $icingaweb2::params::monitoring_instance_config
      }
    },
    defaults => {
      content_template => $icingaweb2::params::config_template,
      owner            => $icingaweb2::params::config_owner,
      group            => $icingaweb2::params::config_group,
      mode             => 0640
    },
    require => Corl::File["${base_name}_dir"]
  }
}