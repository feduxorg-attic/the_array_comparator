# encoding: utf-8

# the main module
module TheArrayComparator
  # the available strategies
  module SearchingStrategies
    # strategy contains substring
    class ContainsAnyWithSubstringSearch < Base
      # Create a new instance of strategy
      #
      # @see Base
      def initialize(sample = Sample.new)
        super
      end

      # Check the keywords with the data
      #
      # @return [Boolean]
      #   The result of the check
      def success?
        return true if @keywords.blank? && @data.blank?

        return true if @data.any? do |line|
          # does a keyword match and it is not an the exception list
          @keywords.any? { |k| line[k] } && !@exceptions.any? { |e| line[e] }
        end

        false
      end
    end
  end
end
