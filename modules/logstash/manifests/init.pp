# vi: set ft=puppet noet shiftwidth=2 tabstop=2 :

class logstash (
	$release	 = "2.3",
	$es_target = "localhost:9200",
) {
# install logstash
	apt::key { 'logstash':
		id     => '46095ACC8548582C1A2699A9D27D666CD88E42B4',
		server => 'pgp.mit.edu',
	} -> apt::source { 'logstash':
		ensure	 => present,
		location => "http://packages.elastic.co/logstash/${release}/debian",
		release	 => 'stable',
		repos    => 'main',
		include	 => {
			src => false,
		}
	} -> package { 'logstash': 
		ensure => present,
	} -> file { '/etc/logstash/':
		ensure  => directory,
		source  => "puppet:///modules/logstash/config",
		recurse => true,
		owner   => "logstash",
		group   => "logstash",
	} -> service { 'logstash':
		enable => true,
		ensure => running,
	}

	if $es_target != undef {
		file { "/etc/logstash/conf.d/99_elasticsearch.conf":
			ensure  => file,
			content => "output { elasticsearch { hosts => [ \"${es_target}\" ] } }",
			require => File['/etc/logstash'],
			notify  => Service['logstash'],
			owner   => "logstash",
			group   => "logstash",
		}
	}
}

