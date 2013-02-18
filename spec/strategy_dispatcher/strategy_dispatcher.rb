#enconding: utf-8
require 'spec_helper'

describe StrategyDispatcher do

  it "let you define must have methods" do
    class KlassTestMustHaveMethodsNoError < StrategyDispatcher
      def self.class_must_have_methods
        [
          :blub
        ]
      end
    end

    expect {
      KlassTestMustHaveMethodsNoError.class_must_have_methods
    }.to_not raise_error
  end

  it "expect that must have methods are defined" do
    class KlassTestMustHaveMethodsError < StrategyDispatcher
    end

    expect {
      binding.pry
      KlassTestMustHaveMethodsNoError.class_must_have_methods
    }.to_not raise_error
  end

#  cache_klass = Class.new do
#    def success?
#      true
#    end
#
#    def initialize(sample=nil)
#    end
#  end
#
#  it "let you register classes" do
#    comparator_instance = double('TestStrategyDispatcherInstance')
#    comparator_instance.stub(:success?).and_return(true)
#
#    comparator_klass = double('TestStrategyDispatcherClass')
#    comparator_klass.stub(:new).and_return(comparator_instance)
#
#    StrategyDispatcher.register(:is_eqal_new, comparator_klass) 
#  end
#
#  it "fails when registering a not suitable class" do
#    comparator_instance = double('TestStrategyDispatcherInstance')
#    comparator_instance.stub(:successasdf?).and_return(true)
#
#    comparator_klass = double('TestStrategyDispatcherClass')
#    comparator_klass.stub(:new).and_return(comparator_instance)
#    expect {
#      StrategyDispatcher.register(:is_eqal_new, comparator_klass) 
#    }.to raise_error Exceptions::IncompatibleStrategy
#  end
#
#  it "let you register and use classes" do
#    comparator_instance = double('TestStrategyDispatcherInstance')
#    comparator_instance.stub(:success?).and_return(true)
#
#    comparator_klass = double('TestStrategyDispatcherClass')
#    comparator_klass.stub(:new).and_return(comparator_instance)
#
#    StrategyDispatcher.register(:new_comp, comparator_klass) 
#
#    comparator = StrategyDispatcher.new
#    comparator.add_check %w{a}, :new_comp , %{a}
#    result = comparator.success?
#
#    expect(result).to eq(true)
#  end

end
