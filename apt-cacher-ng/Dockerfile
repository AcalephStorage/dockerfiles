# BUILD: sudo docker build -t acaleph/apt-cacher-ng:base .
# RUN: sudo docker run -d -v /var/log:/var/log -v /var/cache:/var-cache -p 3142:3142 acaleph/apt-cacher-ng:base

FROM ubuntu:trusty
MAINTAINER acaleph "admin@acale.ph"

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

# Hack for initctl not being available in Ubuntu
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# Repo and packages
RUN apt-get update
RUN apt-get install -y sudo
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget
RUN apt-get install -y lsb-release

#####

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apt-cacher-ng

# Run apt-cacher-ng in offline mode. This presumes that /var/cache/apt-cacher-ng has already been created and pre-seeded
RUN echo 'Offlinemode: 1' >> /etc/apt-cacher-ng/acng.conf

#RUN echo 'Acquire::http { Proxy "http://localhost:3142"; };' | tee /etc/apt/apt.conf

VOLUME ["/var/log/apt-cacher-ng", "/var/cache/apt-cacher-ng"]

EXPOSE 3142
ADD run /usr/local/bin/run
RUN chmod u+x /usr/local/bin/run
ENTRYPOINT ["/usr/local/bin/run"]
