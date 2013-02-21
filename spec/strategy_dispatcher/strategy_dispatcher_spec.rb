#enconding: utf-8
require 'spec_helper'

describe StrategyDispatcher do
  let(:dispatcher_klass) do
    Class.new(StrategyDispatcher) do
      def initialize; end

      def class_must_have_methods
        [
          :success?
        ]
      end

      def exception_to_raise_for_invalid_strategy; end
    end
  end

  let(:strategy_klass) do
    Class.new do
      def success?
        true
      end
    end
  end

  it "let you define must have methods" do
    dispatcher_klass = Class.new(StrategyDispatcher) do
      def class_must_have_methods; end
    end

    expect {
      dispatcher_klass.new.class_must_have_methods
    }.to_not raise_error
  end

  it "expects that must have methods are defined" do
    dispatcher_klass = Class.new(StrategyDispatcher) do; end

    expect {
      dispatcher_klass.new.class_must_have_methods
    }.to raise_error Exceptions::MustHaveMethodNotImplemented

    expect {
      dispatcher_klass.new.exception_to_raise_for_invalid_strategy
    }.to raise_error Exceptions::MustHaveMethodNotImplemented
  end

  it "let you register classes" do
    invalid_strategy_exception = Class.new(Exception)

    dispatcher_klass = Class.new(StrategyDispatcher) do
      def class_must_have_methods; end

      def exception_to_raise_for_invalid_strategy
        invalid_strategy_exception
      end
    end

    expect {
      dispatcher_klass.new.register(:is_eqal_new, strategy_klass) 
    }.to_not raise_error invalid_strategy_exception
  end

  it "fails when you did not set a strategy reader but defined your own initializer" do
    expect {
      dispatcher_klass.new.register(:is_eqal_new, strategy_klass) 
    }.to raise_error Exceptions::WrongUsageOfLibrary
  end

  it "is happy if you define a strategy reader" do
    dispatcher_klass = Class.new(StrategyDispatcher) do
      strategy_reader :avail_strategies

      def class_must_have_methods
        [
          :success?
        ]
      end

      def exception_to_raise_for_invalid_strategy; end
    end

    expect {
      dispatcher_klass.new.register(:is_eqal_new, strategy_klass) 
    }.to_not raise_error Exceptions::WrongUsageOfLibrary
  end

  it "gives you access to the defined strategies via the reader" do
    dispatcher_klass = Class.new(StrategyDispatcher) do
      strategy_reader :strategies

      def class_must_have_methods
        [
          :success?
        ]
      end

      def exception_to_raise_for_invalid_strategy; end
    end

    d = dispatcher_klass.new
    d.register(:is_eqal_new, strategy_klass) 
    s = d.strategies[:is_eqal_new]
    expect(s).to be(strategy_klass)
  end

  it "fails if you try to register an internal keyword" do
    forbidden_keywords = [ 
      :initialize,
      :strategy_reader,
      :register,
      :exception_to_raise_for_invalid_strategy,
      :class_must_have_methods,
      :each,
      :interal_keywords,
      :valid_strategy?,
      :exception_if_not_implemented,
    ]

    def dispatcher_klass(reader)
      Class.new(StrategyDispatcher) do
        strategy_reader reader.to_sym

        def class_must_have_methods
          [
            :success?
          ]
        end

        def exception_to_raise_for_invalid_strategy; end
      end
    end

    forbidden_keywords.each do |w|
      expect{ dispatcher_klass(w) }.to raise_error Exceptions::UsedInternalKeyword
    end
  end

  it "fails when registering a not suitable class" do
    Invalid_strategy_exception = Class.new(Exception)

    dispatcher_klass = Class.new(StrategyDispatcher) do
      def class_must_have_methods
        [ 
          :wow_what_a_method
        ]
      end

      def exception_to_raise_for_invalid_strategy
        Invalid_strategy_exception
      end
    end

    expect {
      dispatcher_klass.new.register(:is_eqal_new, strategy_klass) 
    }.to raise_error Invalid_strategy_exception
  end
end
