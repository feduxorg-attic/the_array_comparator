#encoding: utf-8

# the main module
module TheArrayComparator
  # the available strategies
  module Strategies
    #strategy is equal
    class IsEqual < Base
      
      # Create a new instance of strategy
      #
      # @see Base
      def initialize(sample=Sample.new)
        super

        warning_unsupported_exceptions
      end

      # Check the keywords with the data
      #
      # @return [Boolean]
      #   The result of the check
      def success?
        return true if @keywords.to_a == @data

        false
      end
    end
  end
end
