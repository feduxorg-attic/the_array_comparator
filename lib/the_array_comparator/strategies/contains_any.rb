#encoding: utf-8

# the main module
module TheArrayComparator
  # the available strategies
  module Strategies
    #strategy contains
    class ContainsAny < Base
      
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
        return true if @keywords.blank? and @data.blank?

        if ( @keywords & @data ).blank?
          return false
        else
          return true
        end
      end
    end
  end
end
