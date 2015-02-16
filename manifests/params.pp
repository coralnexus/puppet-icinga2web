
class icingaweb2::params inherits icingaweb2::default {

  include git::params

  #---

  $base_name = 'icingaweb2'

  #-----------------------------------------------------------------------------

  $group_name = module_param('group_name', 'icingaweb2')

  $repo_path = module_param('repo_path')

  $git_user  = module_param('git_user')
  $git_owner = module_param('git_owner', $git::params::owner)
  $git_group = module_param('git_group', $git::params::group)

  $source    = module_param('source', 'https://github.com/icinga/icingaweb2.git')
  $revision  = module_param('master', 'master')
}