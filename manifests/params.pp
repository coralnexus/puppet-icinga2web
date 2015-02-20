
class icingaweb2::params inherits icingaweb2::default {

  include git::params

  #---

  $base_name = 'icingaweb2'

  #-----------------------------------------------------------------------------

  $group_name = module_param('group_name', 'icingaweb2')

  $config_dir   = module_param('config_dir')
  $config_owner = module_param('config_owner')
  $config_group = module_param('config_group')

  $repo_dir  = module_param('repo_dir')
  $source    = module_param('source', 'https://github.com/icinga/icingaweb2.git')
  $revision  = module_param('master', 'master')

  $git_user  = module_param('git_user')
  $git_owner = module_param('git_owner', $git::params::owner)
  $git_group = module_param('git_group', $git::params::group)

  $config_template = module_param('config_template', 'icingawebconfig')

  $auth_config     = module_hash('auth_config', {})
  $config_config   = module_hash('config_config', {})
  $perm_config     = module_hash('perm_config', {})
  $resource_config = module_hash('resource_config', {})

  $monitoring_backend_config  = module_hash('monitoring_backend_config', {})
  $monitoring_config_config   = module_hash('monitoring_config_config', {})
  $monitoring_instance_config = module_hash('monitoring_instance_config', {})
}