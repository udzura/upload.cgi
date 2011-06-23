require 'rubygems'
require 'bundler/setup'
Bundler.require

$LOAD_PATH << File.expand_path('../lib', __FILE__)
require 'gyazo_app'
run GyazoApp
