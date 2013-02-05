#enconding: utf-8
require 'spec_helper'

describe Strategies::ContainsNotWithSubstringSearch do
  let(:data) { %w{ ab c e } }
  let(:exceptions) { %w{ a } }
  let(:keywords_overlap) { %w{ ab } }
  let(:keywords_no_overlap) { %w{ d } }

  it "is successfull when there's a no overlap" do
    comparator = Strategies::ContainsNotWithSubstringSearch.add_probe(data,keywords_no_overlap)
    expect(comparator.success?).to eq(true)
  end

  it "doesn't find something if there's an overlap" do
    comparator = Strategies::ContainsNotWithSubstringSearch.add_probe(data,keywords_overlap)
    expect(comparator.success?).to eq(false)
  end

  it "is successfull although there's an overlap, but an exception defined" do
    comparator = Strategies::ContainsNotWithSubstringSearch.add_probe(data,keywords_overlap, exceptions)
    expect(comparator.success?).to eq(true)
  end
end
