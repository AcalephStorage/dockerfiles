# BUILD: sudo docker build -t acaleph/apt-cacher-ng:base .
# RUN: sudo docker run -d -v /var/log:/var/log -v /var/cache:/var-cache -p 3142:3142 acaleph/apt-cacher-ng:base

FROM ubuntu:precise
MAINTAINER acaleph "admin@acale.ph"

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

# Hack for initctl not being available in Ubuntu
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# Repo and packages
RUN echo deb http://archive.ubuntu.com/ubuntu precise main | tee /etc/apt/sources.list
RUN echo deb http://archive.ubuntu.com/ubuntu precise-updates main | tee -a /etc/apt/sources.list
RUN echo deb http://archive.ubuntu.com/ubuntu precise universe | tee -a /etc/apt/sources.list
RUN echo deb http://archive.ubuntu.com/ubuntu precise-updates universe | tee -a /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y --force-yes wget lsb-release sudo

#####

RUN apt-get install -y apt-cacher-ng
#RUN echo 'Acquire::http { Proxy "http://localhost:3142"; };' | tee /etc/apt/apt.conf

VOLUME /var/log/apt-cacher-ng
VOLUME /var/cache/apt-cacher-ng

EXPOSE 3142
ADD run /usr/local/bin/run
RUN chmod u+x /usr/local/bin/run
ENTRYPOINT ["/usr/local/bin/run"]
