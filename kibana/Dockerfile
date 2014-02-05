# BUILD: sudo docker build -t acaleph/kibana .
# RUN: sudo docker run -d -e ES_HOST=<ES_HOST> -e ES_PORT=<ES_PORT> acaleph/kibana

FROM ubuntu:precise
MAINTAINER acaleph "admin@acale.ph"

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

# Install Dependencies
RUN apt-get update
RUN apt-get install -y -qq curl git nginx-full

# Install Kibana
RUN mkdir -p /src/kibana
RUN cd /src/kibana
RUN curl -sO https://download.elasticsearch.org/kibana/kibana/kibana-3.0.0milestone4.tar.gz
RUN tar --strip-components=1 -xzf kibana-3.0.0milestone4.tar.gz

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

ADD run.sh /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
RUN rm -rf /tmp/*

EXPOSE 80
CMD ["/usr/local/bin/run"]
