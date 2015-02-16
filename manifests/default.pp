
class icingaweb2::default {

  case $::operatingsystem {
    debian, ubuntu: {
      $git_user  = 'root'
      $repo_path = '/usr/share/icingaweb2'
    }
    default: {
      fail("The icingaweb2 module is not currently supported on ${::operatingsystem}")
    }
  }
}
