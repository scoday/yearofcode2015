class httpd::linux {

  package {
    'apache2':
      ensure => installed;
  }

  file {
    '/etc/apache2/test.foo':
      ensure => present,
      content => template('httpd/test.foo.erb'),
      notirfy => Service['apache2'];
  }
}
