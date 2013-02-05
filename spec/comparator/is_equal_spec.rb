#enconding: utf-8
require 'spec_helper'

describe Strategies::IsEqual do
  let(:data) { %w{ a } }
  let(:keywords_overlap) { %w{ a } }
  let(:keywords_no_overlap) { %w{ d } }

  it "fails if keywords are empty" do
    comparator = Strategies::IsEqual.add_probe(data,[])
    expect(comparator.success?).to eq(false)
  end

  it "fails if data is empty" do
    comparator = Strategies::IsEqual.add_probe([],keywords_no_overlap)
    expect(comparator.success?).to eq(false)
  end

  it "is successfull if both keywords and data are empty" do
    comparator = Strategies::IsEqual.add_probe([],[])
    expect(comparator.success?).to eq(true)
  end

  it "is successfull if data and keywords are equal" do
    comparator = Strategies::IsEqual.add_probe(data,keywords_overlap)
    expect(comparator.success?).to eq(true)
  end

  it "fails if data and keywords are different" do
    comparator = Strategies::IsEqual.add_probe(data,keywords_no_overlap)
    expect(comparator.success?).to eq(false)
  end

  #tested at this point for all classes
  it "displays a warning if an exception is defined (is not supported by this strategy)" do
    needed_msg = "Exceptions are not supported by this strategy.\n" 
    msg = capture(:stderr) do
      Strategies::IsEqual.add_probe(data,keywords_no_overlap,%w{a})
    end

    expect(msg).to eq(needed_msg)
  end
end
