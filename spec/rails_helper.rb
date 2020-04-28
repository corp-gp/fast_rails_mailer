# frozen_string_literal: true

require 'nokogiri'

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'
require File.expand_path('../spec/rails_app/config/environment.rb', __dir__)

require 'spec_helper'
