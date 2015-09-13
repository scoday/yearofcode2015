class apache2-svc::linux {
  service {
    'apache2':
      name => "apache2",
      ensure => running,
      enable => true,
    }
}
