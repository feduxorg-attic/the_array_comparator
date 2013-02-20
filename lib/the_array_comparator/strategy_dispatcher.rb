#encoding: utf-8

# the main module
module TheArrayComparator
  # the main comparator shell class
  class StrategyDispatcher

    # Create strategy dispatcher
    def initialize
      @available_strategies = {}
    end

    class << self
      # Define a reader for the available strategies
      #
      # @param [String, Symbol] name
      #   the name for the reader
      def strategy_reader(name)
        raise Exceptions::UsedInternalKeyword,  "You tried to define a reader using an internal name , which is forbidden (your reader name: #{name}). Please choose another name. Thank you very much." if internal_keywords.include? name

        define_method name.to_sym do
          instance_variable_get :@available_strategies
        end
      end

      private

      def internal_keywords
        [
          :initialize,
          :strategy_reader,
          :register,
          :exception_to_raise_for_invalid_strategy,
          :class_must_have_methods,
          :each,
          :interal_keywords,
          :valid_strategy?,
          :exception_if_not_implemented,
        ]
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
    # @raise user defined exception
    #   Raise exception if an incompatible strategy class is given. Please
    #   see #exception_to_raise_for_invalid_strategy for more information
    def register(name,klass)
      if valid_strategy? klass
        available_strategies[name.to_sym] = klass
      else
        raise exception_to_raise_for_invalid_strategy, "Registering #{klass} failed. It does not support \"#{class_must_have_methods.join("-, ")}\"-method"
      end
    end

    # Returns the exception used in registration check
    #
    # @note
    #   has to be implemented by concrete dispatcher -> otherwise exception
    def exception_to_raise_for_invalid_strategy
      exception_if_not_implemented __method__
    end

    # Return all must have methods
    #
    # @note
    #   has to be implemented by concrete dispatcher -> otherwise exception
    def class_must_have_methods
      exception_if_not_implemented __method__
    end

    # Iterate over all strategies
    #
    # @param [Block] block
    #   the block to be executed for each strategy
    #
    # @return [Enumerator]
    #   enumerator over all available strategies
    def each(&block)
      available_strategies.each(block)
    end

    private

    #internal reader
    def available_strategies
      @available_strategies or raise Exceptions::WrongUsageOfLibrary, "You forgot to call \"super()\" in your \"initialize\"-method of your strategy dispatcher #{self.class.name}"
    end

    # Check if given klass is a valid
    def valid_strategy?(klass)
      class_must_have_methods.all? { |m| klass.new.respond_to?(m) }
    end

    # There are methods to be
    # implemented, raise an exception 
    # if one forgot to implement them
    def exception_if_not_implemented(m)
      raise Exceptions::MustHaveMethodNotImplemented, "You forgot to implement the must have method \"#{m}\" in your strategy dispatcher #{self.class.name}"
    end

  end
end
