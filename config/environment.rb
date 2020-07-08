require 'bundler/setup'
Bundler.require

require 'active_record'
require_all 'lib'
require_relative '../db/seeds'

# ENV["PLAYLISTER_ENV"] ||= "development"

# ActiveRecord::Base.establish_connection(ENV["PLAYLISTER_ENV"].to_sym)

# ActiveRecord::Base.logger = nil

# if ENV["PLAYLISTER_ENV"] == "test"
#   ActiveRecord::Migration.verbose = false
# end