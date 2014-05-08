#!/bin/bash
ES_HOST=${ES_PORT_9200_TCP_ADDR:-127.0.0.1}
ES_PORT=${ES_PORT_9200_TCP_PORT:-9300}
EMBEDDED="false"
WORKERS=${ELASTICWORKERS:-1}

if [ "$ES_HOST" = "127.0.0.1" ] ; then
    EMBEDDED="true"
fi

cat << EOF > /opt/logstash.conf
input {
  syslog {
    type => syslog
    port => 514
  }
  # lumberjack {
  #   port => 5043

  #   ssl_certificate => "/opt/certs/logstash-forwarder.crt"
  #   ssl_key => "/opt/certs/logstash-forwarder.key"

  #   type => "$LUMBERJACK_TAG"
  # }
}
filter {
  if [type] == "syslog" {
    grok {
      match => { "message" => "%{SYSLOGTIMESTAMP:syslog_timestamp} %{SYSLOGHOST:syslog_hostname} %{DATA:syslog_program}(?:\[%{POSINT:syslog_pid}\])?: %{GREEDYDATA:syslog_message}" }
      add_field => [ "received_at", "%{@timestamp}" ]
      add_field => [ "received_from", "%{host}" ]
    }
    syslog_pri { }
    date {
      match => [ "syslog_timestamp", "MMM  d HH:mm:ss", "MMM dd HH:mm:ss" ]
    }
  }
}
output {
  stdout {
      codec => "json"
  }

  elasticsearch {
      embedded => $EMBEDDED
      host => "$ES_HOST"
      port => "$ES_PORT"
      workers => $WORKERS
  }
}
EOF

# Due to a bug in 1.4.0 this doesn't work. Using honcho instead
/opt/logstash/bin/logstash agent -f /opt/logstash.conf -- web

# cd /opt/logstash; /usr/local/bin/honcho start

