# vi: set ft=puppet noet shiftwidth=2 tabstop=2 : 

class router (
	$wan_interface = 'ppp0',
	$lan_interface = 'eth0',
	$monitoring_host = '127.0.0.1',
) {
	file { '/etc/sysctl.d/00-forward-ipv4.conf':
		ensure  => file,
		content => 'net.ipv4.ip_forward=1',
	} -> file { '/etc/sysctl.d/01-forward-ipv6.conf':
		ensure  => file,
		content => 'net.ipv6.conf.all.forwarding=1',
	} -> file { '/etc/network/iptables.up.rules':
		ensure  => file,
		content => template('router/iptables.up.rules')
	} -> file { '/etc/network/if-pre-up.d/iptables':
		ensure  => file,
		content => "#!/bin/sh\n/sbin/iptables-restore < /etc/network/iptables.up.rules\nexit 0",
		mode    => "0755",
	}
}
