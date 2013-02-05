#enconding: utf-8
require 'spec_helper'

describe Strategies::ContainsAllWithSubstringSearch do
  let(:data) { %w{ ab c e} }
  let(:exceptions) { %w{ b } }
  let(:keywords_overlap) { %w{ a } }
  let(:keywords_no_overlap) { %w{ d } }
  let(:multiple_keywords_with_one_no_overlap) { %w{ a b cd } }

  it "is successfull when there's a data overlap" do
    comparator = Strategies::ContainsAllWithSubstringSearch.add_probe(data,keywords_overlap)
    expect(comparator.success?).to eq(true)
  end

  it "doesn't find something if there's no overlap" do
    comparator = Strategies::ContainsAllWithSubstringSearch.add_probe(data,keywords_no_overlap)
    expect(comparator.success?).to eq(false)
  end

  it "doesn't find something if there's an exception defined" do
    comparator = Strategies::ContainsAllWithSubstringSearch.add_probe(data,keywords_overlap, exceptions)
    expect(comparator.success?).to eq(false)
  end

  it "doesn't find something if there's an exception defined" do
    comparator = Strategies::ContainsAllWithSubstringSearch.add_probe(data,multiple_keywords_with_one_no_overlap, exceptions)
    expect(comparator.success?).to eq(false)
  end

  it "fails if not all keywords can be found within the data" do
    comparator = Strategies::ContainsAllWithSubstringSearch.add_probe(data,multiple_keywords_with_one_no_overlap)
    expect(comparator.success?).to eq(false)
  end
end
