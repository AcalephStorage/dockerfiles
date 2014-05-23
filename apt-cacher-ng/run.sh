#!/bin/sh

# Make sure the following directories are present on the Docker host:
#    /var/cache/apt-cacher-ng
#    /var/log/apt-cacher-ng

# To run bash interactively:
# docker run -i -t -v /var/log/apt-cacher-ng:/var/log/apt-cacher-ng -v /var/cache/apt-cacher-ng:/var/cache/apt-cacher-ng -p 3142:3142 --entrypoint /bin/bash acaleph/apt-cacher-ng

# Taken from ps -afe|grep apt-cacher-ng while service is running
docker run -d --name apt-cacher-ng \
-v /var/log/apt-cacher-ng:/var/log/apt-cacher-ng \
-v /var/cache/apt-cacher-ng:/var/cache/apt-cacher-ng \
-p 3142:3142 acaleph/apt-cacher-ng
