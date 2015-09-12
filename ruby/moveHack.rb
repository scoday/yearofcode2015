Class endeca::SearchCOE_US (
  $app_name = "SearchCOE_US"
  $endeca_home = "/ngs/app/searchp/scodeca"
  $endeca_apps_dir = "$endeca_home/apps"
  $endeca_project_dir = "$endeca_apps_dir/$app_mname"
  $backup_dir = "$endeca_project_dir/backups"
  $logs_dir = "$endeca_project_dir/logs"
  $logfile = "$endeca_project_dir/logs/endeca_deploy.log"
  $backend_code_zip_fle = ""
  $environment = "uatb"
) {
  # ensure directory structure is created
  file { 
    ["$endeca_home", "$endeca_apps_dir", "$endeca_project_dir", "$backup_dir", "$logs_dir"]:
      ensure    => directory;
    ["$logfile"]
      ensure    => file;
  }

  file { "$backup_dir/config":
    ensure    => absent;
  }
  exec { "mv -f $endeca_project_dir/config $backup_dir":
    path    => ["/usr/bin", "/usr/sbin"];
  }
  file { "$backup_dir/control":
    ensure    => absent;
  }
  exec { "mv -f $endeca_project_dir/control $backup_dir":
    path    => ["/usr/bin", "/usr/sbin"];
  }
  exec { "unzip -o $endeca_apps_dir/$backend_code_zip_fle -d $endeca_project_dir":
    path    => ["/usr/bin", "/usr/sbin"];
  }

  # configuration files in prod
  #exec { "$endeca_project_dir/config/script/PROD.environment.properties $endeca_project_dir/config/script/environment.properties":
  #  path    => ["/usr/bin", "/usr/sbin"];
  #}
  #exec { "cp $endeca_project_dir/config/script/PROD.dgraphs.xml $endeca_project_dir/config/script/dgraphs.xml":
  #  path    => ["/usr/bin", "/usr/sbin"];
  #}
  #exec { "$endeca_project_dir/control/PROD.runcommand.sh $endeca_project_dir/control/runcommand.sh":
  #  path    => ["/usr/bin", "/usr/sbin"];
  #}

  # environment specific
  if $environment == 'uatb'{
    exec { "cp $endeca_project_dir/config/script/uatb.RulesScripts.xml $endeca_project_dir/config/script/RulesScripts.xml":
      path    => ["/usr/bin", "/usr/sbin"];
    }
  }

  if $environment == 'uatb' or 'stagewhite' {
    exec { "cp $endeca_project_dir/control/stage.runcommand.sh $endeca_project_dir/control/runcommand.sh":
      path    => ["/usr/bin", "/usr/sbin"];
    }
  }

  # Copy the appropriate regional config file
    exec { "cp $endeca_project_dir/config/script/$app_name.environment.properties $endeca_project_dir/config/script/region.environment.properties":
      path    => ["/usr/bin", "/usr/sbin"],
      creates => "$endeca_project_dir/config/script/$app_name.environment.properties";
    }
  }

  # set the appropriate permissions on scripts
  exec { "chmod 755 $endeca_project_dir/control/*.sh":
    path    => ["/usr/bin", "/usr/sbin"];
  }

}