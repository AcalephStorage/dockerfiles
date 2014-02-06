# BUILD: sudo docker build -t acaleph/logstash .
# RUN: 
#   default:
#     sudo docker run -d -p 5043:5043 -p 514:514 -p 9200:9200 -p 9292:9292 -p 9300:9300 acaleph/logstash
#   external ES:
#     sudo docker run -d -e ES_HOST=<ES_HOST> -e ES_PORT=<ES_PORT> -p 5043:5043 -p 514:514 -p 9200:9200 -p 9292:9292 -p 9300:9300 acaleph/logstash

FROM ubuntu:precise
MAINTAINER acaleph "admin@acale.ph"

# Ensure UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

ENV DEBIAN_FRONTEND noninteractive

# What tag to use for lumberjack
ENV LUMBERJACK_TAG ACALEPH

# Number of elasticsearch workers
ENV ELASTICWORKERS 1

RUN apt-get update
RUN apt-get install -y wget openjdk-6-jre
RUN wget https://download.elasticsearch.org/logstash/logstash/logstash-1.3.3-flatjar.jar -O /opt/logstash.jar --no-check-certificate 2>/dev/null

ADD run.sh /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
RUN rm -rf /tmp/*

RUN mkdir /opt/certs/
ADD certs/logstash-forwarder.crt /opt/certs/logstash-forwarder.crt
ADD certs/logstash-forwarder.key /opt/certs/logstash-forwarder.key

# syslog
EXPOSE 514

# Lumberjack
EXPOSE 5043

# Log Stash UI
EXPOSE 9292

# Elastic Search
EXPOSE 9200
EXPOSE 9300

CMD ["/usr/local/bin/run"]
