#encoding: utf-8

# the main module
module TheArrayComparator
  # the available strategies
  module Strategies
    #strategy contains
    class ContainsNot < Base
      
      # Create a new instance of strategy
      #
      # @param [Array] data
      #   the data which will be searched
      #
      # @param [Array] keywords
      #   what is the needle to look for
      #
      # @param [Array] exceptions
      #   are there any things which should be not considered as match
      #
      # @return [ContainsWithSubstringSearch] 
      #   the strategy
      def initialize(data=[],keywords=Set.new, exceptions=Set.new)
        super
      end

      # Check the keywords with the data
      #
      # @return [Boolean]
      #   The result of the check
      def success?
        return false if @keywords.blank? and @data.blank?

        if ( @keywords & @data ).blank?
          return true
        else
          return false
        end
      end
    end
  end
end
