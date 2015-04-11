require 'spec_helper'

describe TheArrayComparator::Check do
  strategy_klass = Class.new do
    def success?
      true
    end

    def initialize(_sample = nil)
    end
  end

  sample_klass = Class.new

  it 'add a sample and a comparator' do
    Check.new(strategy_klass, sample_klass.new)
  end

  it 'is true if the check is successfull' do
    check = TheArrayComparator::Check.new(strategy_klass, sample_klass.new)
    result = check.success?
    expect(result).to eq(true)
  end

  it 'is able to return the sample of the check' do
    sample = sample_klass.new
    check = TheArrayComparator::Check.new(strategy_klass, sample)
    expect(check.sample).to eq(sample)
  end
end
