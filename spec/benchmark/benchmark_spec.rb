require 'spec_helper'
require 'strategies_helper'

describe 'benchmark for strategies' do
  let(:count_of_lines) { 100_000 }
  let(:keywords) { %w(a c d) }
  let(:data) { generate_testdata(keywords: keywords, count_of_data: count_of_lines) }

  describe 'strategy contains with substring search' do
    it 'is fast', bm: true do
      keywords = %w(ab c d)
      data = generate_testdata(keywords: keywords, count_of_data: count_of_lines)
      sample = SampleDouble.new(data, keywords)

      comparator = SearchingStrategies::ContainsAllWithSubstringSearch.new(sample)
      time_taken = Benchmark.realtime { comparator.success? }
      expect(time_taken).to be < 1
    end
  end

  describe 'strategy contains' do
    it 'is fast', bm: true do
      sample = SampleDouble.new(data, keywords)
      comparator = SearchingStrategies::ContainsAll.new(sample)
      time_taken = Benchmark.realtime { comparator.success? }
      expect(time_taken).to be < 1
    end
  end

  describe 'caching behaviour' do
    it 'the cache reduces delay', bm: true do
      comparator = Comparator.new
      keyword = %w(a)

      100.times do
        comparator.add_check data, :contains_all, keyword
      end

      time_taken_cold_cache = Benchmark.realtime { comparator.success? }
      time_taken_warm_cache = Benchmark.realtime { comparator.success? }

      expect(time_taken_warm_cache).to be < time_taken_cold_cache
    end

    it 'will be reseted when a new element was added after first access to cache', bm: true do
      comparator = Comparator.new
      keyword = %w(a)

      # cold cache 1
      100.times do
        comparator.add_check data, :contains_all, keyword
      end
      time_taken_cold_cache_1 = Benchmark.realtime { comparator.success? }

      # cold cache 2
      comparator.add_check data, :contains_all, keyword
      time_taken_cold_cache_2 = Benchmark.realtime { comparator.success? }

      # there should be no large difference between those values
      # cold: ~8s
      # warm: <1s
      #
      # therefor all difference larger than 1 should be treated as error
      difference = time_taken_cold_cache_1 - time_taken_cold_cache_2

      expect(difference).to be < 1
    end
  end
end
