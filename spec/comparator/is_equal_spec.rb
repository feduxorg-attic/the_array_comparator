# enconding: utf-8
require 'spec_helper'
require 'strategies_helper'

describe SearchingStrategies::IsEqual do
  let(:data) { %w(a) }
  let(:keywords_overlap) { %w(a) }
  let(:keywords_no_overlap) { %w(d) }

  it 'fails if keywords are empty' do
    sample = SampleDouble.new(data, [])
    comparator = SearchingStrategies::IsEqual.new(sample)
    expect(comparator.success?).to eq(false)
  end

  it 'fails if data is empty' do
    sample = SampleDouble.new([], keywords_no_overlap)
    comparator = SearchingStrategies::IsEqual.new(sample)
    expect(comparator.success?).to eq(false)
  end

  it 'is successfull if both keywords and data are empty' do
    sample = SampleDouble.new([], [])
    comparator = SearchingStrategies::IsEqual.new(sample)
    expect(comparator.success?).to eq(true)
  end

  it 'is successfull if data and keywords are equal' do
    sample = SampleDouble.new(data, keywords_overlap)
    comparator = SearchingStrategies::IsEqual.new(sample)
    expect(comparator.success?).to eq(true)
  end

  it 'fails if data and keywords are different' do
    sample = SampleDouble.new(data, keywords_no_overlap)
    comparator = SearchingStrategies::IsEqual.new(sample)
    expect(comparator.success?).to eq(false)
  end

  # tested at this point for all classes
  it 'displays a warning if an exception is defined (is not supported by this strategy)' do
    needed_msg = "Exceptions are not supported by this strategy.\n"
    sample = SampleDouble.new(data, keywords_no_overlap, %w(a))

    msg = capture(:stderr) do
      SearchingStrategies::IsEqual.new(sample)
    end

    expect(msg).to eq(needed_msg)
  end
end
