#enconding: utf-8
require 'spec_helper'

describe StrategyDispatcher do

  it "let you define must have methods" do
    dispatcher_klass = Class.new(StrategyDispatcher) do
      def self.class_must_have_methods; end
    end

    expect {
      dispatcher_klass.class_must_have_methods
    }.to_not raise_error
  end

  it "expects that must have methods are defined" do
    dispatcher_klass = Class.new(StrategyDispatcher) do; end

    expect {
      dispatcher_klass.class_must_have_methods
    }.to raise_error Exceptions::MustHaveMethodNotImplemented

    expect {
      dispatcher_klass.exception_to_raise_for_invalid_strategy
    }.to raise_error Exceptions::MustHaveMethodNotImplemented
  end

  it "let you register classes" do
    invalid_strategy_exception = Class.new(Exception)

    dispatcher_klass = Class.new(StrategyDispatcher) do
      def self.class_must_have_methods; end

      def self.exception_to_raise_for_invalid_strategy
        invalid_strategy_exception
      end
    end

    strategy_klass = Class.new do
      def success?; end
    end

    expect {
      dispatcher_klass.register(:is_eqal_new, strategy_klass) 
    }.to_not raise_error invalid_strategy_exception
  end

  it "fails when you did not set a strategy reader" do
    dispatcher_klass = Class.new(StrategyDispatcher) do
      def self.class_must_have_methods
        [
          :success?
        ]
      end

      def self.exception_to_raise_for_invalid_strategy; end
    end

    strategy_klass = Class.new do
      def success?; end
    end

    expect {
      dispatcher_klass.register(:is_eqal_new, strategy_klass) 
    }.to raise_error Exceptions::UndefinedStrategyReader
  end

  it "is happy if you define a strategy reader" do
    dispatcher_klass = Class.new(StrategyDispatcher) do
      strategy_reader :avail_strategies

      def self.class_must_have_methods
        [
          :success?
        ]
      end

      def self.exception_to_raise_for_invalid_strategy; end
    end

    strategy_klass = Class.new do
      def success?; end
    end

    expect {
      dispatcher_klass.register(:is_eqal_new, strategy_klass) 
    }.to raise_error Exceptions::UndefinedStrategyReader
  end

  #it "fails when registering a not suitable class" do
  #  comparator_instance = double('TestStrategyDispatcherInstance')
  #  comparator_instance.stub(:successasdf?).and_return(true)

  #  comparator_klass = double('TestStrategyDispatcherClass')
  #  comparator_klass.stub(:new).and_return(comparator_instance)
  #  expect {
  #    StrategyDispatcher.register(:is_eqal_new, comparator_klass) 
  #  }.to raise_error Exceptions::IncompatibleStrategy
  #end

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
