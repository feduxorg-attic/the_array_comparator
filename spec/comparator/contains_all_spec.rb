#enconding: utf-8
require 'spec_helper'
require 'strategies_helper'

describe SearchingStrategies::ContainsAll do
  let(:data) { %w{ a b c e} }
  let(:keywords_overlap) { %w{ a } }
  let(:keywords_no_overlap) { %w{ d } }
  let(:multiple_keywords_with_one_no_overlap) { %w{ a b cd } }

  it "fails if keywords are empty" do
    sample = SampleDouble.new(data,[])
    comparator = SearchingStrategies::ContainsAll.new(sample)
    expect(comparator.success?).to eq(false)
  end

  it "fails if data is empty" do
    sample = SampleDouble.new([],keywords_no_overlap)
    comparator = SearchingStrategies::ContainsAll.new(sample)
    expect(comparator.success?).to eq(false)
  end

  it "is successfull if both keywords and data are empty" do
    sample = SampleDouble.new([],[])
    comparator = SearchingStrategies::ContainsAll.new(sample)
    expect(comparator.success?).to eq(true)
  end

  it "is successfull when there's a data overlap" do
    sample = SampleDouble.new(data,keywords_overlap)
    comparator = SearchingStrategies::ContainsAll.new(sample)
    expect(comparator.success?).to eq(true)
  end

  it "doesn't find something if there's no overlap" do
    sample = SampleDouble.new(data,keywords_no_overlap)
    comparator = SearchingStrategies::ContainsAll.new(sample)
    expect(comparator.success?).to eq(false)
  end

  it "fails if not all keywords can be found within the data" do
    sample = SampleDouble.new(data,multiple_keywords_with_one_no_overlap)
    comparator = SearchingStrategies::ContainsAll.new(sample)
    expect(comparator.success?).to eq(false)
  end

  it "doesn't find something if there's an exception" do
    #not implemented since it's not neccessary
    #just leave the unneed element out of the
    #keyword array
  end
end
