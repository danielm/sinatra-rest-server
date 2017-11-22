#!/bin/bash
#
# File: scripts/provision.sh
# 
# By: Daniel Morales <daniminas@gmail.com>
#
# Web: https://github.com/danielm/sinatra-rest-server
#
# Licence: GPL/MIT

RUBY_VERSION="2.2.2"

main() {
  do_update
  do_tools
  do_rvm
  do_ruby
  do_finish
}

do_update() {
  apt-get update
}

do_tools() {
  # TODO: install NodeJS using NVM
  
  # Some utilities i like to have
  apt-get -y install git nodejs curl git curl unzip
}

do_rvm() {
  #
  # Install rvm
  #
  if ! type rvm >/dev/null 2>&1; then
    curl -sSL https://rvm.io/mpapis.asc | gpg --import -
    curl -L https://get.rvm.io | bash -s stable
    source /etc/profile.d/rvm.sh

    # Add vagrant's users to rvm group
    usermod -a -G rvm vagrant
    usermod -a -G rvm ubuntu
  fi
}

do_ruby() {
  # Install ruby
  if ! rvm list rubies ruby | grep ruby-${RUBY_VERSION}; then
    rvm install ${RUBY_VERSION}
  fi

  # Set our Ruby version
  rvm --default use ${RUBY_VERSION}

  # Install our default global gems
  gem install bundler
}

do_finish() {
  # Remove unnecessary stuff
  apt-get -y autoremove
}

#
# Run EVERYTHING!
#
main
exit 0