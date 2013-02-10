#enconding: utf-8
require 'spec_helper'
require 'strategies_helper'

describe Strategies::Base do

  it "raise an exception if api is not implemented" do
    class TestStrategy < Strategies::Base
    end

    expect {
      test_strategy = TestStrategy.new
      test_strategy.success?
    }.to raise_error Exceptions::IncompatibleComparator
  end
end
