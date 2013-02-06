#enconding: utf-8
require 'spec_helper'
require 'strategies_helper'

describe Strategies::IsNotEqual do
  let(:data) { %w{ a } }
  let(:keywords_overlap) { %w{ a } }
  let(:keywords_no_overlap) { %w{ d } }

  it "is successfull if keywords are empty" do
    sample = SampleDouble.new(data,[])
    comparator = Strategies::IsNotEqual.add_probe(sample)
    expect(comparator.success?).to eq(true)
  end

  it "is successfull if data is empty" do
    sample = SampleDouble.new([],keywords_no_overlap)
    comparator = Strategies::IsNotEqual.add_probe(sample)
    expect(comparator.success?).to eq(true)
  end

  it "fails if both keywords and data are empty" do
    sample = SampleDouble.new([],[])
    comparator = Strategies::IsNotEqual.add_probe(sample)
    expect(comparator.success?).to eq(false)
  end

  it "fails if data and keywords are equal" do
    sample = SampleDouble.new(data,keywords_overlap)
    comparator = Strategies::IsNotEqual.add_probe(sample)
    expect(comparator.success?).to eq(false)
  end

  it "is successfull if data and keywords are different" do
    sample = SampleDouble.new(data,keywords_no_overlap)
    comparator = Strategies::IsNotEqual.add_probe(sample)
    expect(comparator.success?).to eq(true)
  end
end
