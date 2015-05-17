
class icingaweb2::params inherits icingaweb2::default {

  include git::params

  #---

  $base_name = 'icingaweb2'

  #-----------------------------------------------------------------------------

  $user_name  = module_param('user_name', 'icingaweb2')
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

  $auth_config = module_hash('auth_config', {
    icingaweb2 => {
      backend  => module_param('auth_backend', 'db'),
      resource => module_param('auth_resource', 'icingaweb2_db')
    }
  })
  $config_config = module_hash('config_config', {
    logging => {
      log         => module_param('config_log', 'syslog'),
      level       => module_param('config_log_level', 'WARNING'),
      application => module_param('config_log_app', 'icingaweb2')
    },
    preferences => {
      resource => module_param('config_pref_resource', 'icingaweb2_db'),
      store    => module_param('config_pref_store', 'ini')
    }
  })
  $role_config = module_hash('role_config', {
    admins => {
      users       => module_param('role_users', 'admin'),
      permissions => module_param('role_permissions', '*')
    }
  })
  $resource_config = module_hash('resource_config', {
    icingaweb2_db => {
      type     => module_param('resource_web_type', 'db'),
      db       => module_param('resource_web_db_type', 'mysql'),
      host     => module_param('resource_web_db_host', 'localhost'),
      port     => module_param('resource_web_db_port', '3306'),
      dbname   => module_param('resource_web_db_name', 'icingaweb2'),
      username => module_param('resource_web_db_user', 'icingaweb2'),
      password => module_param('resource_web_db_password', '12345'),
      prefix   => module_param('resource_web_db_prefix', 'icingaweb_')
    },
    icinga_ido => {
      type     => module_param('resource_ido_type', 'db'),
      db       => module_param('resource_ido_db_type', 'mysql'),
      host     => module_param('resource_ido_db_host', 'localhost'),
      port     => module_param('resource_ido_db_port', '3306'),
      dbname   => module_param('resource_ido_db_name', 'icinga2'),
      username => module_param('resource_ido_db_user', 'icinga2'),
      password => module_param('resource_ido_db_password', '12345')
    },
    livestatus => {
      type    => module_param('monitoring_livestatus_type', 'livestatus'),
      socket  => module_param('monitoring_livestatus_socket')
    }
  })

  $monitoring_backend_config = module_hash('monitoring_backend_config', {
    icinga => {
      type     => module_param('monitoring_backend_type', 'ido'),
      resource => module_param('monitoring_backend_resource', 'icinga_ido')
    }
  })
  $monitoring_config_config = module_hash('monitoring_config_config', {
    security => {
      protected_customvars => module_param('monitoring_protected_customvars', '*pw*,*pass*,community')
    }
  })
  $monitoring_instance_config = module_hash('monitoring_instance_config', {
    icinga => {
      transport => module_param('monitoring_instance_transport', 'local'),
      path      => module_param('monitoring_instance_path')
    }
  })
}