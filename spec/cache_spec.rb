require 'spec_helper'

describe Cache do
  it "let you register classes" do
    must_have_methods = [
      :add,
      :clear,
      :stored_objects,
      :delete_object,
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
    cache_instance = double('TestCacheInstance')
    cache_instance.stub(:blub) 

    caching_strategy_klass = double('TestCachingStrategyClass')
    caching_strategy_klass.stub(:new).and_return(cache_instance)

    expect {
      Cache.register(:test_cache, caching_strategy_klass) 
    }.to raise_error Exceptions::IncompatibleCachingStrategy
  end

  it "let you add a cache" do
    Cache.add(:test, :anonymous_cache)
    data = %w{ a b c d}

    expect {
      Cache[:test].add data
    }.to_not raise_error
  end

  it "fails if an unknown cache strategy is given" do
    data = %w{ a b c d}

    expect {
      Cache.add(:test, :anonymous_cache_abc)
    }.to raise_error Exceptions::UnknownCachingStrategy 
  end

  it "fails if an unknown cache is given" do
    data = %w{ a b c d}

    expect {
      cache[:test123].add data
    }.to raise_error
  end

  it "returns the cache after adding it" do
    cache = Cache.add(:test, :anonymous_cache)
    data = %w{ a b c d}

    expect( cache.class ).to be(Cache::AnonymousCache)
  end

end
