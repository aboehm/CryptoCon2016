# vi: set ft=puppet noet shiftwidth=2 tabstop=2 :

class kibana (
	$release   = '4.5',
	$es_target = "http://localhost:9200",
	$base_path = undef,
) {
	$home = "/opt/kibana"
	$config = "${home}/config/kibana.yml"
	$port = 5601
	$iface = "0.0.0.0"
	$es_host = "${es_target}"

	class { 'kibana::repo': 
    release	=> $release
	} -> package { 'kibana':
		ensure  => present
	}-> class { 'kibana::configure':
	} -> service { 'kibana':
		enable  => true, 
		ensure	=> running,
	}
}

class kibana::configure inherits kibana {
	file { $config:
		ensure  => file,
		content => template('kibana/kibana.yml'),
		owner   => 'kibana',
		group   => 'kibana',
		mode    => '0640',
		notify  => Service['kibana'],
	}
}

class kibana::repo (
	$release = '4.5',
) {
	apt::key { 'elastic':
		id	     => '46095ACC8548582C1A2699A9D27D666CD88E42B4',
		server	 => 'pgp.mit.edu',
	} -> apt::source { 'kibana':
		ensure	 => present,
		location => "http://packages.elastic.co/kibana/${release}/debian",
		release	 => 'stable',
		repos		 => 'main',
		include	 => {
			src => false,
		}
	}
}


