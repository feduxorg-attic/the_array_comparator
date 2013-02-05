#encoding: utf-8

# the main module
module TheArrayComparator
  # the available strategies
  module Strategies
    # strategy contains substring
    class ContainsAllWithSubstringSearch < Base

      # Create a new instance of strategy
      #
      # @see Base
      def initialize(sample)
        super
      end

      # Check the keywords with the data
      #
      # @return [Boolean]
      #   The result of the check
      def success?
        return true if @keywords.blank? and @data.blank?

        #return true if @data.all? do |line| 
        #  #does a keyword match and it is not an the exception list
        #  binding.pry
        #  @keywords.all?{ |k| line[k] } and not @exceptions.any?{ |e| line[e] }
        #end

        return true if @keywords.all? do |word| 
          #does a keyword match and it is not an the exception list
          @data.any?{ |line| line[word] and not @exceptions.any?{ |e| line[e] } }
        end

        false
      end
    end
  end
end
