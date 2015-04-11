# enconding: utf-8
require 'spec_helper'
require 'strategies_helper'

describe SearchingStrategies::Base do
  it 'raise an exception if api is not implemented' do
    class TestStrategy < SearchingStrategies::Base
    end

    expect do
      test_strategy = TestStrategy.new
      test_strategy.success?
    end.to raise_error Exceptions::IncompatibleComparator
  end
end
