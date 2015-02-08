
class icinga2web::default {

  case $::operatingsystem {
    debian, ubuntu: {
      $user      = 'root'
      $repo_path = '/usr/share/icingaweb2'
    }
    default: {
      fail("The icinga2web module is not currently supported on ${::operatingsystem}")
    }
  }
}
