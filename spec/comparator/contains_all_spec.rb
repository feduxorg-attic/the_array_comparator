#enconding: utf-8
require 'spec_helper'

describe Strategies::ContainsAll do
  let(:data) { %w{ a b c e} }
  let(:keywords_overlap) { %w{ a } }
  let(:keywords_no_overlap) { %w{ d } }
  let(:multiple_keywords_with_one_no_overlap) { %w{ a b cd } }

  it "fails if keywords are empty" do
    comparator = Strategies::ContainsAll.add_probe(data,[])
    expect(comparator.success?).to eq(false)
  end

  it "fails if data is empty" do
    comparator = Strategies::ContainsAll.add_probe([],keywords_no_overlap)
    expect(comparator.success?).to eq(false)
  end

  it "is successfull if both keywords and data are empty" do
    comparator = Strategies::ContainsAll.add_probe([],[])
    expect(comparator.success?).to eq(true)
  end

  it "is successfull when there's a data overlap" do
    comparator = Strategies::ContainsAll.add_probe(data,keywords_overlap)
    expect(comparator.success?).to eq(true)
  end

  it "doesn't find something if there's no overlap" do
    comparator = Strategies::ContainsAll.add_probe(data,keywords_no_overlap)
    expect(comparator.success?).to eq(false)
  end

  it "fails if not all keywords can be found within the data" do
    comparator = Strategies::ContainsAll.add_probe(data,multiple_keywords_with_one_no_overlap)
    expect(comparator.success?).to eq(false)
  end

  it "doesn't find something if there's an exception" do
    #not implemented since it's not neccessary
    #just leave the unneed element out of the
    #keyword array
  end
end
