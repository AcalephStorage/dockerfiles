#!/bin/sh

docker build -t acaleph/apt-cacher-ng:base .

docker run -v /var/log:/var/log -v /var/cache:/var/cache acaleph/apt-cacher-ng:base /home/apt-cacher-ng/post-build.sh

LAST=`docker ps -l -q`
docker commit -run='{"Cmd": ["/usr/sbin/apt-cacher-ng", "-c", "/etc/apt-cacher-ng", "pidfile=/var/run/apt-cacher-ng/pid", "SocketPath=/var/run/apt-cacher-ng/socket", "foreground=1"]}' $LAST acaleph/apt-cacher-ng:vagrant

cat <<EOF

NOTE:
-----
You will have to add the following line

    Acquire::http { Proxy "http://10.0.2.2:3142"; };

To /etc/apt/apt.conf in your Virtualbox virtual machines.

Or, replace 10.0.2.2 with the actual hostname/IP of the docker host in other environments.
EOF
