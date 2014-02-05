#!/bin/bash
ES_HOST=${ES_HOST:-127.0.0.1}
ES_PORT=${ES_PORT:-9200}

cat << EOF > /usr/share/nginx/www/config.js
define(['settings'],
function (Settings) {


  return new Settings({
    elasticsearch:    "http://$ES_HOST:$ES_PORT",
    kibana_index:     "kibana-int",
    panel_names: [
      'histogram',
      'map',
      'pie',
      'table',
      'filtering',
      'timepicker',
      'text',
      'fields',
      'hits',
      'dashcontrol',
      'column',
      'derivequeries',
      'trends',
      'bettermap',
      'query',
      'terms'
    ]
  });
});
EOF

nginx -c /etc/nginx/nginx.conf
