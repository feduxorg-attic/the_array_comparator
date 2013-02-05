#enconding: utf-8
require 'spec_helper'

describe Strategies::ContainsAllWithSubstringSearch do
  let(:data) { %w{ ab c e} }
  let(:exceptions) { %w{ b } }
  let(:keywords_overlap) { %w{ a } }
  let(:keywords_no_overlap) { %w{ d } }
  let(:multiple_keywords_with_one_no_overlap) { %w{ a b cd } }

  class Sample < Struct(:keywords,:data,:exceptions,:tag)
    def initialize(keywords,data,exceptions,tag)
      @keywords = keywords
      @data = data
      @exceptions = exceptions
      @tag = tag
    end
  end

  it "is successfull when there's a data overlap" do
    sample = Sample.new(data,keywords_overlap)
    comparator = Strategies::ContainsAllWithSubstringSearch.add_probe(sample)
    expect(comparator.success?).to eq(true)
  end

  it "doesn't find something if there's no overlap" do
    sample = Sample.new(data,keywords_no_overlap)
    comparator = Strategies::ContainsAllWithSubstringSearch.add_probe(sample)
    expect(comparator.success?).to eq(false)
  end

  it "doesn't find something if there's an exception defined" do
    sample = Sample.new(data,keywords_overlap, exceptions)
    comparator = Strategies::ContainsAllWithSubstringSearch.add_probe(sample)
    expect(comparator.success?).to eq(false)
  end

  it "doesn't find something if there's an exception defined" do
    sample = Sample.new(data,multiple_keywords_with_one_no_overlap, exceptions)
    comparator = Strategies::ContainsAllWithSubstringSearch.add_probe(sample)
    expect(comparator.success?).to eq(false)
  end

  it "fails if not all keywords can be found within the data" do
    sample = Sample.new(data,multiple_keywords_with_one_no_overlap)
    comparator = Strategies::ContainsAllWithSubstringSearch.add_probe(sample)
    expect(comparator.success?).to eq(false)
  end
end
