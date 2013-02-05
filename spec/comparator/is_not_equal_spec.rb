#enconding: utf-8
require 'spec_helper'

describe Strategies::IsNotEqual do
  let(:data) { %w{ a } }
  let(:keywords_overlap) { %w{ a } }
  let(:keywords_no_overlap) { %w{ d } }

  it "is successfull if keywords are empty" do
    comparator = Strategies::IsNotEqual.add_probe(data,[])
    expect(comparator.success?).to eq(true)
  end

  it "is successfull if data is empty" do
    comparator = Strategies::IsNotEqual.add_probe([],keywords_no_overlap)
    expect(comparator.success?).to eq(true)
  end

  it "fails if both keywords and data are empty" do
    comparator = Strategies::IsNotEqual.add_probe([],[])
    expect(comparator.success?).to eq(false)
  end

  it "fails if data and keywords are equal" do
    comparator = Strategies::IsNotEqual.add_probe(data,keywords_overlap)
    expect(comparator.success?).to eq(false)
  end

  it "is successfull if data and keywords are different" do
    comparator = Strategies::IsNotEqual.add_probe(data,keywords_no_overlap)
    expect(comparator.success?).to eq(true)
  end
end
