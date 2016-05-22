# vi: set ft=puppet noet shiftwidth=2 tabstop=2 :

class { 'logstash':
	es_target => '192.168.33.2:9200'
}

class { 'elasticsearch':
}

class { 'kibana':
	es_target => "http://192.168.33.2:9200/"
}


