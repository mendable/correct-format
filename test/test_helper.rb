ENV['RAILS_ENV'] = 'test' 
ENV['RAILS_ROOT'] ||= File.dirname(__FILE__) + '/../../../..' 

require 'test/unit'
require File.expand_path(File.join(ENV['RAILS_ROOT'], 'config/environment.rb')) 

# Establish DB Connection
require 'sqlite3'
conf = YAML::load(File.open(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.establish_connection(conf['sqlite3'])


# Load the schema
require 'test/fixtures/schema.rb'

# make sure our plugin is loaded
#require File.dirname(__FILE__) + '/../init.rb'
