# -*- coding: utf-8 -*-
if mongo_uri = ENV['MONGOHQ_URL']
  Mongoid.database = Mongo::Connection.from_uri(mongo_uri).
                         db(URI.parse(mongo_uri).path.gsub(/^\//, ''))
else # can spin up on local
  host = 'localhost'
  port = Mongo::Connection::DEFAULT_PORT
 
  database_name = case ENV['RACK_ENV'].to_sym
    when :development then 'udzura_demo_development'
    when :production  then 'udzura_demo_production'
    when :test        then 'udzura_demo_test'
  end
  Mongoid.database = Mongo::Connection.new(host, port).db(database_name)
end
