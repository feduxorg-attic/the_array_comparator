# the main module
module TheArrayComparator
  # the available strategies
  module Strategies
    #base class for strategies
    class Base
      class << self
        # Add a new probe to check for 
        # @see initialize
        def add_probe(*args,&block)
          new(*args,&block)
        end
      end

      # Create a new instance of strategy
      #
      # @param [Array] data
      #   the data which will be searched
      #
      # @param [Set] keywords
      #   what is the needle to look for
      #
      # @param [Set] exceptions
      #   are there any things which should be not considered as match
      #
      # @return [Object] 
      #   the strategy
      def initialize(data=[],keywords=Set.new,exceptions=Set.new)
        @data = data
        @keywords = Set.new(keywords)
        @exceptions = Set.new(exceptions)
      end

      # Check the keywords with the data
      #
      # @info
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
