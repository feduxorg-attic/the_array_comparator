#enconding: utf-8
require 'spec_helper'

describe CachingStrategies::SingleValueCache do

  let(:cache) { CachingStrategies::SingleValueCache.new }

  it "adds abitrary objects to cache" do
    expect {
      cache.add %w{obj}
    }.to_not raise_error
  end

  it "returns one and only object" do
    objects = []

    objects << cache.add('obj')
    objects << cache.add('obj')

    expect(cache.stored_objects).to eq([ objects.last ])
  end

  it "clears cache" do
    cache.add('obj')
    expect(cache.stored_objects.size).to eq(1) 

    cache.clear
    expect(cache.stored_objects.size).to eq(0) 
  end

  it "tells the requester if there are new objects" do
    cache.add('obj')
    expect(cache.new_objects?).to eq(true) 
  end

  it "tells the requester if there __no__ new objects" do
    cache.add('obj')
    cache.stored_objects
    expect(cache.new_objects?).to eq(false) 
  end

  it "works with sub-sequent requests to the cache as well" do
    cache.add('obj')
    cache.stored_objects
    cache.add('obj')
    expect(cache.new_objects?).to eq(true) 

    cache.add('obj')
    cache.stored_objects
    cache.add('obj')
    cache.stored_objects
    expect(cache.new_objects?).to eq(false) 
  end

  it "returns the same objecs if requested multiple times" do
    cache.add('obj')
    run1 = cache.stored_objects
    run2 = cache.stored_objects

    expect(run1).to be(run2) 
    expect(run1).to eq(run2) 
  end

  it "deletes specific objects from cache (by number)" do
    c_created = cache.add('obj')
    c_deleted = cache.delete_object

    expect(c_deleted).to eq(c_created)
  end

  it "gets you a specific object" do
    c_created = cache.add('obj')
    c_fetched = cache.fetch_object

    expect(c_fetched).to eq(c_created)
  end
end
