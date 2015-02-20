
class icingaweb2::default {

  case $::operatingsystem {
    debian, ubuntu: {
      $git_user    = 'root'
      $repo_dir    = '/usr/share/icingaweb2'

      $config_dir   = '/etc/icingaweb2'
      $config_owner = 'root'
      $config_group = 'root'
    }
    default: {
      fail("The icingaweb2 module is not currently supported on ${::operatingsystem}")
    }
  }
}
