# BUILD: sudo docker build -t acaleph/logstash .
# RUN: 
#   default:
#     sudo docker run -d -p 5043:5043 -p 514:514 -p 9200:9200 -p 9292:9292 -p 9300:9300 acaleph/logstash
#   external ES:
#     sudo docker run -d -e ES_HOST=<ES_HOST> -e ES_PORT=<ES_PORT> -p 5043:5043 -p 514:514 -p 9200:9200 -p 9292:9292 -p 9300:9300 acaleph/logstash

FROM ubuntu:precise
MAINTAINER acaleph "admin@acale.ph"

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

ENV DEBIAN_FRONTEND noninteractive

# What tag to use for lumberjack
ENV LUMBERJACK_TAG LOGSTASH

# Number of elasticsearch workers
ENV ELASTICWORKERS 1
# Make sure jRuby is installed
ENV USE_JRUBY 1

RUN echo 'deb http://us.archive.ubuntu.com/ubuntu/ precise universe' >> /etc/apt/sources.list
RUN apt-get update

# RUN apt-get install python python-pip -y
# RUN pip install honcho

# A hack to fix fuse issue with Java 7
RUN apt-get install -y --force-yes libfuse2
RUN cd /tmp ; apt-get download fuse
RUN cd /tmp ; dpkg-deb -x fuse_* .
RUN cd /tmp ; dpkg-deb -e fuse_*
RUN cd /tmp ; rm fuse_*.deb
RUN cd /tmp ; echo -en '#!/bin/bash\nexit 0\n' > DEBIAN/postinst
RUN cd /tmp ; dpkg-deb -b . /fuse.deb
RUN cd /tmp ; dpkg -i /fuse.deb


RUN apt-get install -y wget openjdk-7-jre
RUN wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.1.tar.gz -O /opt/logstash-1.4.1.tar.gz --no-check-certificate 2>/dev/null
RUN cd /opt;tar zxf /opt/logstash-1.4.1.tar.gz && mv /opt/logstash-1.4.1 /opt/logstash

# RUN /opt/logstash/bin/logstash deps

ADD run.sh /opt/logstash/bin/run.sh
RUN chmod +x opt/logstash/bin/run.sh

# ADD Procfile /opt/logstash/

#RUN mkdir /opt/certs/
#ADD certs/logstash-forwarder.crt /opt/certs/logstash-forwarder.crt
#ADD certs/logstash-forwarder.key /opt/certs/logstash-forwarder.key

# syslog
EXPOSE 514

# Lumberjack
EXPOSE 5043

# Log Stash UI
EXPOSE 9292

# Elastic Search
EXPOSE 9200
EXPOSE 9300

VOLUMES ['/data', '/opt/logstash.conf']

CMD ["/opt/logstash/bin/run.sh"]
