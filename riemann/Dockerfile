# BUILD: sudo docker build -t acaleph/riemann .

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

RUN apt-get install -y openjdk-7-jre-headless

ADD riemann_0.2.4_all.deb /tmp/riemann_0.2.4_all.deb
RUN dpkg -i /tmp/riemann_0.2.4_all.deb

EXPOSE 4567
CMD ["status"]
ENTRYPOINT ["service", "riemann"]