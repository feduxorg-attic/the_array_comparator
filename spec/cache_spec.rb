require 'spec_helper'

describe Cache do
  it "let you register classes" do
    must_have_methods = [
      :add,
      :clear,
      :stored_objects,
      :delete_objects,
      :new_objects?,
      :fetch_object,
    ]

    cache_instance = double('TestCacheInstance')
    must_have_methods.each { |m| cache_instance.stub(m) }

    caching_strategy_klass = double('TestCachingStrategyClass')
    caching_strategy_klass.stub(:new).and_return(cache_instance)

    expect {
      Cache.register(:test_cache, caching_strategy_klass) 
    }.to_not raise_error Exceptions::IncompatibleCachingStrategy
  end

  it "fails when registering a not suitable class" do
    comparator_instance = double('TestComparatorInstance')
    comparator_instance.stub(:successasdf?).and_return(true)

    comparator_klass = double('TestComparatorClass')
    comparator_klass.stub(:new).and_return(comparator_instance)
    expect {
      Comparator.register(:is_eqal_new, comparator_klass) 
    }.to raise_error Exceptions::IncompatibleComparator
  end

end
