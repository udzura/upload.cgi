ENV['RACK_ENV'] = 'test'

require 'rubygems'
require 'bundler/setup'
Bundler.require()
Bundler.require(:test)
$LOAD_PATH << File.expand_path('../../lib', __FILE__)

RSpec.configure do |c|
  c.include Rack::Test::Methods

  c.before :all do
    Gyazo::Image.delete_all
  end
 
  c.after :all do
    Gyazo::Image.delete_all
  end
end

require 'gyazo_app'

def app
  GyazoApp.new
end
