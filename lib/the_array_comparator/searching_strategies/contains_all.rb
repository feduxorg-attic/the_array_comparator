#encoding: utf-8

# the main module
module TheArrayComparator
  # the available strategies
  module SearchingStrategies
    #strategy contains
    class ContainsAll < Base
      
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
        return true if @keywords.blank? and @data.blank?
        return false if @keywords.blank? or @data.blank?

        if ( @keywords - @data ).blank?
          return true
        else
          return false
        end
      end
    end
  end
end
