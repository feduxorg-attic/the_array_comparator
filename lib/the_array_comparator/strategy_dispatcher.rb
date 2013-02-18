#encoding: utf-8

# the main module
module TheArrayComparator
  # the main comparator shell class
  class StrategyDispatcher

    @available_strategies = {}

    class << self

      def strategy_reader(name)
        class << self
          define_method name.to_sym do
            instance_variable_get :@available_strategies
          end
        end
      end

      # Register a new comparator strategy
      #
      # @param [String,Symbol] name
      #   The name which can be used to refer to the registered strategy
      #
      # @param [Comparator] klass
      #   The strategy class which should be registered
      #
      # @raise Exceptions::IncompatibleComparator
      #   Raise exception if an incompatible comparator class is given
      def register(name,klass)
        if valid_strategy? klass
          @available_strategies[name.to_sym] = klass
        else
          raise exception_invalid_strategy, "Registering #{klass} failed. It does not support \"#{class_must_have_methods.join("-, ")}\"-method"
        end
      end

      # Returns the exception used in registration check
      #
      # @note
      #   has to be implemented by concrete dispatcher -> otherwise exception
      def exception_invalid_strategy
        exception_if_not_implemented __method__
      end

      # Return all must have methods
      #
      # @note
      #   has to be implemented by concrete dispatcher -> otherwise exception
      def class_must_have_methods
        exception_if_not_implemented __method__
      end

      # Check if given klass is a valid
      # caching strategy
      #
      # @param [Object] klass
      #   the class to be checked
      #
      # @return [TrueClass,FalseClass]
      #   the result of the check, true if valid 
      #   klass is given
      def valid_strategy?(klass)
        class_must_have_methods.all? { |m| klass.new.respond_to?(m) }
      end

      # Iterate over all strategies
      #
      # @param [Block] block
      #   the block to be executed for each strategy
      #
      # @return [Enumerator]
      #   enumerator over all available strategies
      def each(&block)
        @available_strategies.each(block)
      end
    end

    private

    def exception_if_not_implemented(m)
      raise MustHaveMethodNotImplemented, "You forgot to implement the must have method #{m}! in your strategy wrapper #{self.name}"
    end
  end
end
