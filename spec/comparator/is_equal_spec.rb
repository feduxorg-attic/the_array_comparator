#enconding: utf-8
require 'spec_helper'

describe Strategies::IsEqual do
  let(:data) { %w{ a } }
  let(:keywords_overlap) { %w{ a } }
  let(:keywords_no_overlap) { %w{ d } }

  it "fails if keywords are empty" do
    sample = Sample.new(data,[])
    comparator = Strategies::IsEqual.add_probe(sample)
    expect(comparator.success?).to eq(false)
  end

  it "fails if data is empty" do
    sample = Sample.new([],keywords_no_overlap)
    comparator = Strategies::IsEqual.add_probe(sample)
    expect(comparator.success?).to eq(false)
  end

  it "is successfull if both keywords and data are empty" do
    sample = Sample.new([],[])
    comparator = Strategies::IsEqual.add_probe(sample)
    expect(comparator.success?).to eq(true)
  end

  it "is successfull if data and keywords are equal" do
    sample = Sample.new(data,keywords_overlap)
    comparator = Strategies::IsEqual.add_probe(sample)
    expect(comparator.success?).to eq(true)
  end

  it "fails if data and keywords are different" do
    sample = Sample.new(data,keywords_no_overlap)
    comparator = Strategies::IsEqual.add_probe(sample)
    expect(comparator.success?).to eq(false)
  end

  #tested at this point for all classes
  it "displays a warning if an exception is defined (is not supported by this strategy)" do
    needed_msg = "Exceptions are not supported by this strategy.\n" 
    sample = Sample.new(data,keywords_no_overlap,%w{a})

    msg = capture(:stderr) do
      Strategies::IsEqual.add_probe(sample)
    end

    expect(msg).to eq(needed_msg)
  end
end
