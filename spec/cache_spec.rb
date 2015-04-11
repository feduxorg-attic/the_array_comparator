require 'spec_helper'

describe Cache do
  it 'let you add a cache' do
    cache = Cache.new
    cache.add(:test, :anonymous_cache)
    data = %w(a b c d)

    expect do
      cache[:test].add data
    end.to_not raise_error
  end

  it 'fails if an unknown cache strategy is given' do
    cache = Cache.new

    expect do
      cache.add(:test, :anonymous_cache_abc)
    end.to raise_error Exceptions::UnknownCachingStrategy
  end

  it 'fails if an unknown cache is given' do
    data = %w(a b c d)

    expect do
      cache[:test123].add data
    end.to raise_error
  end

  it 'returns the cache after adding it' do
    cache = Cache.new
    cache.add(:test, :anonymous_cache)

    expect(cache[:test].class).to be(CachingStrategies::AnonymousCache)
  end
end
