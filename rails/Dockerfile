# Acaleph Rails
#
# To be built and used as a base image for Rails apps. Uses ONBUILD commands to be executed in the app image

FROM ubuntu:precise
MAINTAINER acaleph "admin@acale.ph"

RUN echo 'deb http://us.archive.ubuntu.com/ubuntu/ precise universe' >> /etc/apt/sources.list
RUN apt-get -y update

# make sure the package repository is up to date
RUN apt-get install -y python-software-properties build-essential wget

# Up to date Ruby Repo
RUN apt-add-repository -y ppa:brightbox/ruby-ng
RUN apt-get update

# INSTALL SYSTEM DEPENDENCIES
RUN apt-get install git sudo ruby2.1 ruby2.1-dev mysql-client libmysqlclient-dev net-tools nano libssl-dev sqlite3 libsqlite3-dev -y

# Cleanup
RUN apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

# Install bundler
RUN gem install bundler

ONBUILD RUN mkdir -p /app

# Copy the Gemfile and Gemfile.lock into the image.
# Temporarily set the working directory to where they are.
# This is meant to cache Gemfile generation
ONBUILD WORKDIR /tmp
ONBUILD ADD Gemfile /tmp/Gemfile
ONBUILD ADD Gemfile.lock /tmp/Gemfile.lock
ONBUILD RUN bundle install
# --without development test

# Copy App
ONBUILD ADD . /app

# Switch back to App directory
ONBUILD WORKDIR /app

ONBUILD ENV RAILS_ENV production
ONBUILD RUN bundle exec rake assets:precompile

ONBUILD EXPOSE 3000

ONBUILD CMD ["start"]
ONBUILD ENTRYPOINT ["/app/bin/docker_start"]
