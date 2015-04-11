# encoding: utf-8

# the main module
module TheArrayComparator
  # the available strategies
  module SearchingStrategies
    # base class for strategies
    class Base
      # Create a new instance of strategy
      #
      # @param [Sample] sample
      #    the probe which should be used for the check
      #
      # @return [Object]
      #   the strategy
      def initialize(sample = Sample.new)
        @data = sample.data
        @keywords = sample.keywords
        @exceptions = sample.exceptions
        @tag = sample.tag
      end

      # Check the keywords with the data
      #
      # @note
      #   needs to be implemented by the concrete strategy
      # @raise [RuntimeError]
      #   error when not implemented by strategy
      def success?
        fail Exceptions::IncompatibleComparator, 'The chosen comparator is incompatible, Please check the documentation for comparator strategies on how to build a compatible one.'
      end

      private

      def warning_unsupported_exceptions
        warn 'Exceptions are not supported by this strategy.' unless @exceptions.blank?
      end
    end
  end
end
