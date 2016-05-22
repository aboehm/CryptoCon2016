# vi: set ft=puppet noet shiftwidth=2 tabstop=2 :

class rsyslog (
	$syslog_host,
	$syslog_port     = 514,
	$syslog_protocol = "udp",
) {
	file { '/etc/rsyslog.conf':
		ensure  => file,
		content => template("rsyslog/rsyslog.conf")
	} -> service { 'rsyslog':
		enable => true,
		ensure => running,
	}
}
