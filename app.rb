require 'rubygems'
require 'bundler'
Bundler.require(:default)
Dir["#{File.dirname(__FILE__)}/app/**/*.rb"].each { |f| require f }
