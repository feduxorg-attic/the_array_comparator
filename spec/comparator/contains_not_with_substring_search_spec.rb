#enconding: utf-8
require 'spec_helper'
require 'strategies_helper'

describe Strategies::ContainsNotWithSubstringSearch do
  let(:data) { %w{ ab c e } }
  let(:exceptions) { %w{ a } }
  let(:keywords_overlap) { %w{ ab } }
  let(:keywords_no_overlap) { %w{ d } }

  it "is successfull when there's a no overlap" do
    sample = SampleDouble.new(data,keywords_no_overlap)
    comparator = Strategies::ContainsNotWithSubstringSearch.add_check(sample)
    expect(comparator.success?).to eq(true)
  end

  it "doesn't find something if there's an overlap" do
    sample = SampleDouble.new(data,keywords_overlap)
    comparator = Strategies::ContainsNotWithSubstringSearch.add_check(sample)
    expect(comparator.success?).to eq(false)
  end

  it "is successfull although there's an overlap, but an exception defined" do
    sample = SampleDouble.new(data,keywords_overlap, exceptions)
    comparator = Strategies::ContainsNotWithSubstringSearch.add_check(sample)
    expect(comparator.success?).to eq(true)
  end
end
