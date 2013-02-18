#enconding: utf-8
require 'spec_helper'

describe StrategyDispatcher do
  cache_klass = Class.new do
    def success?
      true
    end

    def initialize(sample=nil)
    end
  end

  it "let you register classes" do
    comparator_instance = double('TestStrategyDispatcherInstance')
    comparator_instance.stub(:success?).and_return(true)

    comparator_klass = double('TestStrategyDispatcherClass')
    comparator_klass.stub(:new).and_return(comparator_instance)

    expect {
      StrategyDispatcher.register(:is_eqal_new, comparator_klass) 
    }.to_not raise_error Exceptions::IncompatibleStrategyDispatcher
  end

  it "fails when registering a not suitable class" do
    comparator_instance = double('TestStrategyDispatcherInstance')
    comparator_instance.stub(:successasdf?).and_return(true)

    comparator_klass = double('TestStrategyDispatcherClass')
    comparator_klass.stub(:new).and_return(comparator_instance)
    expect {
      StrategyDispatcher.register(:is_eqal_new, comparator_klass) 
    }.to raise_error Exceptions::IncompatibleStrategyDispatcher
  end

  it "let you register and use classes" do
    comparator_instance = double('TestStrategyDispatcherInstance')
    comparator_instance.stub(:success?).and_return(true)

    comparator_klass = double('TestStrategyDispatcherClass')
    comparator_klass.stub(:new).and_return(comparator_instance)

    StrategyDispatcher.register(:new_comp, comparator_klass) 

    comparator = StrategyDispatcher.new
    comparator.add_check %w{a}, :new_comp , %{a}
    result = comparator.success?

    expect(result).to eq(true)
  end

end
