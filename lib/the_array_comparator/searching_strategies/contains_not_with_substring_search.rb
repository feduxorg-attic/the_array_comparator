#encoding: utf-8

# the main module
module TheArrayComparator
  # the available strategies
  module SearchingStrategies
    # strategy not contains substring
    class ContainsNotWithSubstringSearch < Base

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

        return true if @data.all? do |line| 
          #if a keyword is found, check if there's an exception
          @keywords.none?{ |k| line[k] } or @exceptions.any?{ |e| line[e] }
        end

        false
      end
    end
  end
end
