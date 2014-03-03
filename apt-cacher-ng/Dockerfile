# BUILD: sudo docker build -t acaleph/riemann .
# RUN: sudo docker run -d -v /etc/riemann:/etc/riemann -p 5555:5555 -p 5556:5556 acaleph/riemann

FROM ubuntu:precise
MAINTAINER acaleph "admin@acale.ph"

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

# Hack for initctl not being available in Ubuntu
# RUN dpkg-divert --local --rename --add /sbin/initctl
# RUN ln -sf /bin/true /sbin/initctl

# Repo and packages
RUN echo deb http://archive.ubuntu.com/ubuntu precise main | tee /etc/apt/sources.list
RUN echo deb http://archive.ubuntu.com/ubuntu precise-updates main | tee -a /etc/apt/sources.list
RUN echo deb http://archive.ubuntu.com/ubuntu precise universe | tee -a /etc/apt/sources.list
RUN echo deb http://archive.ubuntu.com/ubuntu precise-updates universe | tee -a /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y --force-yes wget lsb-release sudo

#####

RUN apt-get install -y apt-cacher-ng
RUN echo 'Acquire::http { Proxy "http://localhost:3142"; };' | tee /etc/apt/apt.conf

EXPOSE 3142
#ENTRYPOINT ["/usr/sbin/apt-cacher-ng", "-c", "/etc/apt-cacher-ng", "pidfile=/var/run/apt-cacher-ng/pid", "SocketPath=/var/run/apt-cacher-ng/socket", "foreground=1"]
