#enconding: utf-8
require 'spec_helper'

describe Strategies::ContainsAny do
  let(:data) { %w{ a b c e} }
  let(:keywords_overlap) { %w{ a } }
  let(:keywords_no_overlap) { %w{ d } }

  it "fails if keywords are empty" do
    comparator = Strategies::ContainsAny.add_probe(data,[])
    expect(comparator.success?).to eq(false)
  end

  it "fails if data is empty" do
    comparator = Strategies::ContainsAny.add_probe([],keywords_no_overlap)
    expect(comparator.success?).to eq(false)
  end

  it "is successfull if both keywords and data are empty" do
    comparator = Strategies::ContainsAny.add_probe([],[])
    expect(comparator.success?).to eq(true)
  end

  it "is successfull when there's a data overlap" do
    comparator = Strategies::ContainsAny.add_probe(data,keywords_overlap)
    expect(comparator.success?).to eq(true)
  end

  it "doesn't find something if there's no overlap" do
    comparator = Strategies::ContainsAny.add_probe(data,keywords_no_overlap)
    expect(comparator.success?).to eq(false)
  end

  it "doesn't find something if there's an exception" do
    #not implemented since it's not neccessary
    #just leave the unneed element out of the
    #keyword array
  end
end
