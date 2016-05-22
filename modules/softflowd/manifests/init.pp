# vi: set ft=puppet noet shiftwidth=2 tabstop=2 :

class softflowd (
	$es_target = "http://localhost:9200",
	$interface = "eth0",
) {
	file { '/usr/local/sbin/softflowd':
		ensure => file,
		source => 'puppet:///modules/softflowd/x86-64/softflowd',
		owner  => root,
		group  => root,
		mode   => '0755',
	} -> file { '/usr/local/sbin/softflowctl':
		ensure => file,
		source => 'puppet:///modules/softflowd/x86-64/softflowctl',
		owner  => root,
		group  => root,
		mode   => '0755',
	} -> file { '/etc/rc.local':
		ensure  => file,
		mode    => '0755',
		content => "#!/bin/sh -e\n/usr/local/sbin/softflowd -i ${interface} -e ${es_target} -d &\n exit 0",
	}
}

