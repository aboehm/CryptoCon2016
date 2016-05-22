# vi: set ft=puppet noet shiftwidth=2 tabstop=2 :

class packetbeat (
	$interface = "eth0",
	$es_target = "http://localhost:9200",
) {
	$config = "/etc/packetbeat/packetbeat.yml"

	class { 'packetbeat::repo': 
	} -> package { 'packetbeat':
		ensure  => present
	} -> class { 'packetbeat::configure':
	} -> service { 'packetbeat':
		enable  => true, 
		ensure	=> running,
	}
}

class packetbeat::configure inherits packetbeat {
	file { $config:
		ensure  => file,
		content => template('packetbeat/packetbeat.yml'),
		mode    => '0640',
		notify  => Service['packetbeat'],
	}
}

class packetbeat::repo (
) {
	apt::key { 'packetbeat':
		id	     => '46095ACC8548582C1A2699A9D27D666CD88E42B4',
		server	 => 'pgp.mit.edu',
	} -> apt::source { 'packetbeat':
		ensure	 => present,
		location => "http://packages.elastic.co/beats/apt",
		release	 => 'stable',
		repos		 => 'main',
		include	 => {
			src => false,
		}
	}
}

