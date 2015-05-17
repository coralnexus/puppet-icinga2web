
class icingaweb2::default {

  case $::operatingsystem {
    debian, ubuntu: {
      $git_user    = 'root'
      $repo_dir    = '/usr/share/icingaweb2'

      $config_dir   = '/etc/icingaweb2'
      $config_owner = 'root'
      $config_group = 'root'

      $monitoring_instance_path     = '/var/run/icinga2/cmd/icinga2.cmd'
      $monitoring_livestatus_socket = '/var/run/icinga2/cmd/livestatus'
    }
    default: {
      fail("The icingaweb2 module is not currently supported on ${::operatingsystem}")
    }
  }
}
