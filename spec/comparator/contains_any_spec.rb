#enconding: utf-8
require 'spec_helper'

describe Strategies::ContainsAny do
  let(:data) { %w{ a b c e} }
  let(:keywords_overlap) { %w{ a } }
  let(:keywords_no_overlap) { %w{ d } }

  it "fails if keywords are empty" do
    sample = Sample.new(data,[])
    comparator = Strategies::ContainsAny.add_probe(sample)
    expect(comparator.success?).to eq(false)
  end

  it "fails if data is empty" do
    sample = Sample.new([],keywords_no_overlap)
    comparator = Strategies::ContainsAny.add_probe(sample)
    expect(comparator.success?).to eq(false)
  end

  it "is successfull if both keywords and data are empty" do
    sample = Sample.new([],[])
    comparator = Strategies::ContainsAny.add_probe(sample)
    expect(comparator.success?).to eq(true)
  end

  it "is successfull when there's a data overlap" do
    sample = Sample.new(data,keywords_overlap)
    comparator = Strategies::ContainsAny.add_probe(sample)
    expect(comparator.success?).to eq(true)
  end

  it "doesn't find something if there's no overlap" do
    sample = Sample.new(data,keywords_no_overlap)
    comparator = Strategies::ContainsAny.add_probe(sample)
    expect(comparator.success?).to eq(false)
  end

  it "doesn't find something if there's an exception" do
    #not implemented since it's not neccessary
    #just leave the unneed element out of the
    #keyword array
  end
end
