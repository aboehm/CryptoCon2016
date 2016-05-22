# vi: set ft=puppet noet shiftwidth=2 tabstop=2 :

class { 'router':
  wan_interface   => "eth0",
  lan_interface   => "eth1",
	monitoring_host => "192.168.33.2",
}

class { 'rsyslog':
	syslog_host     => "192.168.33.2",
	syslog_port     => 10514,
	syslog_protocol => "udp",
}

class { 'softflowd':
	es_target => "http://192.168.33.2:9200",
	interface => "eth1",
}

class { 'packetbeat':
	es_target => "192.168.33.2:9200",
	interface => "eth1",
}

