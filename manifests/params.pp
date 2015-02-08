
class icinga2web::params inherits icinga2web::default {

  include git::params

  #---

  $base_name = 'icinga2web'

  #-----------------------------------------------------------------------------

  $group_name = module_param('group_name', 'icingaweb2')

  $repo_path = module_param('repo_path')

  $user      = module_param('user')
  $owner     = module_param('owner', $git::params::owner)
  $group     = module_param('group', $git::params::group)

  $source    = module_param('source', 'https://github.com/icinga/icingaweb2.git')
  $revision  = module_param('master', 'master')
}