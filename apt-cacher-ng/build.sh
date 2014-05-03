#!/bin/sh

docker build -t acaleph/apt-cacher-ng . && cat <<EOF

NOTE:
-----
You will have to add the following line

    Acquire::http { Proxy "http://10.0.2.2:3142"; };

To /etc/apt/apt.conf in your Virtualbox virtual machines.

Or, replace 10.0.2.2 with the actual hostname/IP of the docker host in other environments.
EOF
