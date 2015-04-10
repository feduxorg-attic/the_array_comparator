#encoding: utf-8

$LOAD_PATH << File.expand_path('../lib' , File.dirname(__FILE__))

unless ENV['TRAVIS_CI'] == 'true'
  require 'pry'
  require 'byebug'
  require 'ap'
  require 'ffaker'
  require 'benchmark'
end

require 'stringio'
require 'tempfile'

require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/numeric/time'
#require 'active_support/core_ext/kernel/reporting'

unless ENV['TRAVIS_CI'] == 'true'
  require 'simplecov'
  SimpleCov.start
end

require 'the_array_comparator'
require 'the_array_comparator/testing_helper/data_set'
require 'the_array_comparator/testing_helper/test_data'
require 'the_array_comparator/testing_helper'

RSpec.configure do |c|
#  c.treat_symbols_as_metadata_keys_with_true_values = true
#  c.filter_run_including :focus => true
end

include TheArrayComparator
include TheArrayComparator::TestingHelper

#ENV['PATH'] = '/bin'
