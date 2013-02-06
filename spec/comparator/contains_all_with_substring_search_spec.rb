#enconding: utf-8
require 'spec_helper'
require 'strategies_helper'

describe Strategies::ContainsAllWithSubstringSearch do
  let(:data) { %w{ ab c e} }
  let(:exceptions) { %w{ b } }
  let(:keywords_overlap) { %w{ a } }
  let(:keywords_no_overlap) { %w{ d } }
  let(:multiple_keywords_with_one_no_overlap) { %w{ a b cd } }

  it "is successfull when there's a data overlap" do
    sample = SampleDouble.new(data,keywords_overlap)
    comparator = Strategies::ContainsAllWithSubstringSearch.add_probe(sample)
    expect(comparator.success?).to eq(true)
  end

  it "doesn't find something if there's no overlap" do
    sample = SampleDouble.new(data,keywords_no_overlap)
    comparator = Strategies::ContainsAllWithSubstringSearch.add_probe(sample)
    expect(comparator.success?).to eq(false)
  end

  it "doesn't find something if there's an exception defined" do
    sample = SampleDouble.new(data,keywords_overlap, exceptions)
    comparator = Strategies::ContainsAllWithSubstringSearch.add_probe(sample)
    expect(comparator.success?).to eq(false)
  end

  it "doesn't find something if there's an exception defined" do
    sample = SampleDouble.new(data,multiple_keywords_with_one_no_overlap, exceptions)
    comparator = Strategies::ContainsAllWithSubstringSearch.add_probe(sample)
    expect(comparator.success?).to eq(false)
  end

  it "fails if not all keywords can be found within the data" do
    sample = SampleDouble.new(data,multiple_keywords_with_one_no_overlap)
    comparator = Strategies::ContainsAllWithSubstringSearch.add_probe(sample)
    expect(comparator.success?).to eq(false)
  end
end
