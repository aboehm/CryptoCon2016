# vi: set ft=puppet noet shiftwidth=2 tabstop=2 :

class elasticsearch (
	$release	= "2.x"
) {
	# install elasticsearch
	apt::key { 'elasticsearch':
	  id     => '46095ACC8548582C1A2699A9D27D666CD88E42B4',
		server => 'pgp.mit.edu',
	} -> apt::source { 'elasticsearch':
		ensure   => present,
		location => "http://packages.elastic.co/elasticsearch/${release}/debian",
		release  => 'stable',
		repos		 => 'main',
		include	 => {
			src => false,
		}
	} -> package { 'elasticsearch': 
		ensure => present,
	} -> service { 'elasticsearch':
		enable => true,
		ensure => running,
	}
}

