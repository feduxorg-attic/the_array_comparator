#encoding: utf-8

# the main module
module TheArrayComparator
  # the available strategies
  module Strategies
    #strategy is not equal
    class IsNotEqual < Base
      
      # Create a new instance of strategy
      #
      # @see Base
      def initialize(data=[],keywords=Set.new, exceptions=Set.new)
        super

        warning_unsupported_exceptions
      end

      # Check the keywords with the data
      #
      # @return [Boolean]
      #   The result of the check
      def success?
        return true if @keywords.to_a != @data

        false
      end
    end
  end
end
