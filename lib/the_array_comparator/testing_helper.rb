# the main module
module TheArrayComparator
  # helper for tests
  module TestingHelper
    # Generate data for the tests
    #
    # @param [Hash] options
    #
    # @option options [Array] :keywords
    #   the keywords which should be hidden in the data
    #
    # @option options [Array] :raw_data
    #   the data which should be used to hide the keywords
    #
    # @option options [Integer] :count_of_data
    #   how much raw data should be generated if none is given
    #
    # @return [Array]
    #   the testdata (raw_data + keywords)
    def generate_testdata(options)
      opts = {
        keywords: [],
        raw_data: [],
        count_of_data: 100
      }.merge options

      raw_data = options[:raw_data] || FFaker::Lorem.sentences(opts[:count_of_data])
      dataset = DataSet.new(options[:keywords], raw_data)

      testdata = TestData.new(dataset)
      testdata.generate
    end
  end
end

# Kernel
module Kernel
  #
  # Captures the given stream and returns it:
  #
  #   stream = capture(:stdout) { puts 'Cool' }
  #   stream # => "Cool\n"
  def capture(stream)
    begin
      stream = stream.to_s
      eval "$#{stream} = StringIO.new"
      yield
      result = eval("$#{stream}").string
    ensure
      eval("$#{stream} = #{stream.upcase}")
    end

    result
  end
end
