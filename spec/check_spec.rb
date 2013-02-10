require 'spec_helper'

describe Check do
  strategy_klass = Class.new do
    def success?
      true
    end

    def initialize(sample=nil)
    end
  end

  sample_klass = Class.new do; end

  it "add a sample and a comparator" do
    Check.new(strategy_klass,sample_klass.new)
  end

  it "is true if the check is successfull" do
    check = Check.new(strategy_klass,sample_klass.new)
    result = check.success?
    expect(result).to eq(true)
  end

  it "is false if the check failed" do
    check = Check.new(strategy_klass,sample_klass.new)
    result = check.failed?
    expect(result).to eq(false)
  end
end
