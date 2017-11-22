#
# File: app/config.ru
# 
# By: Daniel Morales <daniminas@gmail.com>
#
# Web: https://github.com/danielm/sinatra-rest-server
#
# Licence: GPL/MIT

require 'sinatra'

set :run, false
set :environment, ENV['RACK_ENV'] || 'development'

require './src/main'
run Sinatra::Application
