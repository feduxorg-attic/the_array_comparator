#enconding: utf-8
require 'spec_helper'
require 'strategies_helper'

describe Strategies::ContainsAnyWithSubstringSearch do
  let(:data) { %w{ ab c e} }
  let(:exceptions) { %w{ b} }
  let(:keywords_overlap) { %w{ a } }
  let(:multiple_overlap) { %w{ a c d} }
  let(:keywords_no_overlap) { %w{ d } }

  it "is successfull when there's a data overlap (at least one element)" do
    sample = SampleDouble.new(data,keywords_overlap)
    comparator = Strategies::ContainsAnyWithSubstringSearch.add_probe(sample)
    expect(comparator.success?).to eq(true)
  end

  it "doesn't find something if there's no overlap" do
    sample = SampleDouble.new(data,keywords_no_overlap)
    comparator = Strategies::ContainsAnyWithSubstringSearch.add_probe(sample)
    expect(comparator.success?).to eq(false)
  end

  it "doesn't find something if there's an exception defined" do
    sample = SampleDouble.new(data,keywords_overlap, exceptions)
    comparator = Strategies::ContainsAnyWithSubstringSearch.add_probe(sample)
    expect(comparator.success?).to eq(false)
  end

  it "is successfull, if there's a least one match (second match 'c' -> exception -> no match) " do
    sample = SampleDouble.new(data,multiple_overlap, exceptions)
    comparator = Strategies::ContainsAnyWithSubstringSearch.add_probe(sample)
    expect(comparator.success?).to eq(true)
  end
end
