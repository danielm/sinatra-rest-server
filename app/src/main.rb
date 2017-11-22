#
# File: app/src/main.rb
# 
# By: Daniel Morales <daniminas@gmail.com>
#
# Web: https://github.com/danielm/sinatra-rest-server
#
# Licence: GPL/MIT

require 'sinatra'
require 'sinatra/activerecord'

require './src/models'

################################
# Application Routes
################################

configure do
  ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "development.db"
  )

  set :show_exceptions, true

  # Binds to 0.0.0.0 to allow Vagrant port-forwarding from host OS.
  set :bind, '0.0.0.0'
end

# Home
get "/" do
  # Just print a message here, we arent going to implement nothing else here
  "It Works!"
end

# Service1: Return all our Text entities
get "/api/texts/all" do
  # Sets the response content type
  # Header: Content-Type: application/json
  content_type :json

  # Text.all.order returns all entities in the database
  # 
  # to_json: 
  # It serializes the results into a JSON objects, in this
  # case its an array of elements. Each element contains all the
  # fields in the table: id,name,message,created_at,updated_at
  #
  # to_json is a very powerfull helper, see the next point to check what options you can pass
  Text.all.order(created_at: :desc).to_json
end

# Service2: Return ONLY ONE Text entity, by ID
get "/api/texts/:id" do
  # Lets get one Text element from our DB by id
  text = Text.find_by_id params[:id]
  if text.nil?
    halt 404
  end

  # Sets the response content type
  # Header: Content-Type: application/json
  content_type :json

  # Now we return the serialized object, in this case
  #
  # By using the :only option, we can pass what we want to return as an array
  # By specifying :name and :message we tell the helper thats all we want
  # (id, created_at and update_at fields) will be ignored and not returned
  #
  # to_json is a very powerfull helper, see the next point to check what other options you can pass
  text.to_json({:only => [:name, :message]})
end

################################
# 404
################################
not_found do
  'Whatever you are looking for its not here!'
end

################################
# 500
################################
error do
  'Sorry there was a nasty error - ' + env['sinatra.error'].name
end
