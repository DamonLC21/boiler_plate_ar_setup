require 'bundler/setup'
Bundler.require

require 'active_record'
require_all 'lib'
require_relative '../db/seeds'
ActiveRecord::Base.logger = nil