class varnish 
  (
    $varnish_listen_address = "$::ipaddress_eth0",
    $varnish_listen_port    = '80',
    $backend_host           = '127.0.0.1',
    $backend_port           = '80',
  ) {
  package {'varnish':
    ensure => 'installed'
  }
  service {'varnish':
    ensure  => 'running',
    enable  => true,
    require => Package['varnish'],
  }
  file {'/etc/sysconfig/varnish':
    mode    => 0644,
    owner   => 0,
    group   => 0,
    content => template('varnish/sysconfig-varnish.erb'),
    notify  => Service['varnish']
  }
  file {'/etc/varnish/default.vcl':
    mode    => 0644,
    owner   => 0,
    group   => 0,
    content => template('varnish/default.vcl.erb'),
    notify  => Service['varnish'],
  }
}
