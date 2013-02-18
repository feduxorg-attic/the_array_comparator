require 'spec_helper'

describe Cache do

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
