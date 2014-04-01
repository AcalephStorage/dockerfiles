dockerfiles
===========

A collection of Dockerfiles for Acaleph Projects

Logstash
--------

OpenSSL certificates are required for Lumberjack (previously known as logstash-forwarder).

    cd logstash && mkdir certs && cd certs
    openssl req -x509 -batch -nodes -newkey rsa:2048 -keyout logstash-forwarder.key -out logstash-forwarder.crt
