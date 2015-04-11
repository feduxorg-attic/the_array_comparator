module TheArrayComparator
  module TestingHelper
    # Keywords only make sense together with the raw data
    class DataSet
      # @!attribute [rw] keywords
      #  keywords which need to be hidden in the raw data
      #
      # @!attribute [rw] raw_data
      #  the raw data which should be used to hide the keywords
      attr_accessor :keywords, :raw_data

      # Create new instance
      #
      # @return [DataSet]
      #   the object holding the data
      def initialize(keywords = [], raw_data = [])
        @keywords = keywords
        @raw_data = raw_data
      end

      # A stripe of data
      #
      # @return [Array]
      #   a pice of raw data
      def stripe_of_data
        raw_data.shift(stripe_size)
      end

      # A tripe of the keywords
      #
      # @return [String,Integer]
      #   one keyword
      def stripe_of_keywords
        keywords.shift unless keywords.blank?
      end

      # The count of the keywords
      # @return [Integer]
      #   How many key words are available
      def count_of_keywords
        keywords.size
      end

      private

      def divisor
        if count_of_keywords > 0 && count_of_keywords <= count_of_rawdata
          return count_of_keywords
        else
          return 1
        end
      end

      def stripe_size
        raw_data.size / divisor
      end

      def count_of_rawdata
        raw_data.size
      end
    end
  end
end
