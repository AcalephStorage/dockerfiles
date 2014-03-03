#!/bin/sh

# Make sure the following directories are present on the Docker host:
#    /var/cache/apt-cacher-ng
#    /var/log/apt-cacher-ng
#
# Taken from ps -afe|grep apt-cacher-ng while service is running
docker run -d -v /var/log:/var/log -v /var/cache/apt-cacher-ng:/var/cache/apt-cacher-ng -p 3142:3142 acaleph/apt-cacher-ng
