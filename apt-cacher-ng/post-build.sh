#!/bin/bash

mkdir -p /var/log/apt-cacher-ng
chown apt-cacher-ng:apt-cacher-ng /var/log/apt-cacher-ng

mkdir -p /var/cache/apt-cacher-ng
chown apt-cacher-ng:apt-cacher-ng /var/cache/apt-cacher-ng
