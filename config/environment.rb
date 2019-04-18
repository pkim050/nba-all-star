ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

#ActiveRecord::Base.establish_connection(
#  ENV['DATABASE_URL'] || { adapter: 'sqlite3',
#  database: "db/#{ENV['SINATRA_ENV']}.sqlite" }
#)

set :database_file, "./database.yml"

#require 'dotenv'
#Dotenv.load

require './app/controllers/application_controller'
require_all 'app'
