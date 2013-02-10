require 'spec_helper'


describe "benchmark for strategies" do
  let(:count_of_lines) { 100000 }

  describe "strategy contains with substring search" do
    let(:keywords) { %w{ab c d} }
    let(:data) { generate_testdata(keywords: keywords, count_of_data: count_of_lines) }

    it "is fast", :bm => true do
      comparator = Strategies::ContainsWithSubstringSearch.add_check(data,keywords)
      time_taken = Benchmark.realtime { comparator.success? }
      expect(time_taken).to be < 1
    end
  end

  describe "strategy contains" do
    let(:keywords) { %w{a c d} }
    let(:data) { generate_testdata(keywords: keywords, count_of_data: count_of_lines) }

    it "is fast", :bm => true do
      comparator = Strategies::Contains.add_check(data,keywords)
      time_taken = Benchmark.realtime { comparator.success? }
      expect(time_taken).to be < 1
    end
  end
end
