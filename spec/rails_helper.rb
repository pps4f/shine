#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
#---
# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist
Capybara.default_driver = :poltergeist

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
	config.fixture_path = "#{::Rails.root}/spec/fixtures"

	config.use_transactional_fixtures = false
	config.infer_spec_type_from_file_location!	

	config.before(:suite) do
		DatabaseCleaner.clean_with(:truncation)
	end

	config.before(:each) do
		DatabaseCleaner.strategy = :transaction
	end

	config.before(:each, :type => :feature) do
		DatabaseCleaner.strategy = :truncation
	end

	config.before(:each) do
		DatabaseCleaner.start
	end

	config.after(:each) do
		DatabaseCleaner.clean
	end
end