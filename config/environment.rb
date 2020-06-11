ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

 configure :development do 
    set :database, {adapter: 'sqlite3', database: 'db/AADB.db'}
 end

 if ENV['SINATRA_ENV'] == 'development'
   require_relative '../secrets'
 end

 require_all 'app'