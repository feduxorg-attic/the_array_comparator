# the main module
module TheArrayComparator
  # the available strategies
  module Strategies
    #base class for strategies
    class Base
      class << self
        # Add a new probe to check for 
        # @see initialize
        def add_check(*args,&block)
          new(*args,&block)
        end
      end

      # Create a new instance of strategy
      #
      # @param [Sample] sample
      #    the probe which should be used for the check
      #
      # @return [Object] 
      #   the strategy
      def initialize(sample)
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
        raise
      end

      private 

      def warning_unsupported_exceptions
        warn "Exceptions are not supported by this strategy." unless @exceptions.blank?
      end
    end
  end
end
