require 'spec_helper'

describe "#generate_testdata" do

  it "spread the testdata when amount of data is lower than keywords" do
    data = generate_testdata(keywords: %w{a b c d}, raw_data: %w{data1 data2})
    expect(data[2]).to eq('a')
  end

  it "spread the testdata when amount of data is equal to the amount of the keywords" do
    data = generate_testdata(keywords: %w{a b c d}, raw_data: %w{data1 data2 data3 data4})
    expect(data[1]).to eq('a')
    expect(data[2]).to eq('data2')
  end

  it "spread the testdata when amount of data is larger than keywords" do
    data = generate_testdata(keywords: %w{a b c d}, raw_data: %w{data1 data2 data3 data4 data5})
    expect(data[1]).to eq('a')
  end

  it "spread the testdata when amount of data is not a multiply of keywords (it cares for the rest)" do
    data = generate_testdata(keywords: %w{a b c d}, raw_data: [ 'data' ] * 99 )
    expect(data[2]).to eq('data')
    expect(data[24]).to eq('a')
  end
end
