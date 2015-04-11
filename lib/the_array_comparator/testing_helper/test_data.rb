module TheArrayComparator
  module TestingHelper
    # Test Data
    class TestData
      # Create test data instance
      #
      # @return [TestData]
      #   the test data object used to generate the test data
      def initialize(dataset)
        @dataset = dataset
        @data = []
      end

      # Generate the test data
      #
      # @return [Array]
      #   the test data
      def generate
        if @data.blank?
          @dataset.count_of_keywords.times do
            @data.concat @dataset.stripe_of_data
            @data << @dataset.stripe_of_keywords
          end

          # put the rest into the output
          @data.concat @dataset.raw_data
        end

        @data
      end
    end
  end
end
