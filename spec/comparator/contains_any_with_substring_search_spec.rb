#enconding: utf-8
require 'spec_helper'

describe Strategies::ContainsAnyWithSubstringSearch do
  let(:data) { %w{ ab c e} }
  let(:exceptions) { %w{ b} }
  let(:keywords_overlap) { %w{ a } }
  let(:multiple_overlap) { %w{ a c d} }
  let(:keywords_no_overlap) { %w{ d } }

  it "is successfull when there's a data overlap (at least one element)" do
    comparator = Strategies::ContainsAnyWithSubstringSearch.add_probe(data,keywords_overlap)
    expect(comparator.success?).to eq(true)
  end

  it "doesn't find something if there's no overlap" do
    comparator = Strategies::ContainsAnyWithSubstringSearch.add_probe(data,keywords_no_overlap)
    expect(comparator.success?).to eq(false)
  end

  it "doesn't find something if there's an exception defined" do
    comparator = Strategies::ContainsAnyWithSubstringSearch.add_probe(data,keywords_overlap, exceptions)
    expect(comparator.success?).to eq(false)
  end

  it "is successfull, if there's a least one match (second match 'c' -> exception -> no match) " do
    comparator = Strategies::ContainsAnyWithSubstringSearch.add_probe(data,multiple_overlap, exceptions)
    expect(comparator.success?).to eq(true)
  end
end
