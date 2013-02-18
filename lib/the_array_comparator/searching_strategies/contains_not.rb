#encoding: utf-8

# the main module
module TheArrayComparator
  # the available strategies
  module SearchingStrategies
    #strategy contains
    class ContainsNot < Base
      
      # Create a new instance of strategy
      #
      # @see Base
      def initialize(sample=Sample.new)
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
