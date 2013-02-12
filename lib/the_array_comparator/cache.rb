#encoding: utf-8

# the main module
module TheArrayComparator
  #caching class
  module Cache

    # Variable to store caching strategies
    @caching_strategies = {}

    # Variable to store available caches
    @caches = {}

    class << self
     #
      # @!attribute [rw] command
      #   Return all available caching strategies
      attr_reader :caching_strategies

      # Register a new comparator strategy
      #
      # @param [String,Symbol] name
      #   The name which can be used to refer to the registered caching strategy
      #
      # @param [Comparator] klass
      #   The caching strategy class which should be registered
      #
      # @raise Exceptions::IncompatibleCachingStrategy
      #   Raise exception if an incompatible comparator class is given
      def register(name,klass)
        if valid_strategy? klass
          @caching_strategies[name.to_sym] = klass
        else
          raise Exceptions::IncompatibleCachingStrategy, "Registering #{klass} failed. It does not support #{must_have_methods.join("-, ")}-instance-methods"
        end
      end

      # Return all must have methods
      #
      # @return [Array]
      #   the array of must have methods
      def must_have_methods
        [
          :add,
          :clear,
          :stored_objects,
          :new_objects?,
          :delete_object,
          :fetch_object,
        ]
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

        must_have_methods.all? { |m| klass.new.respond_to?(m) }
      end

      # Retrieve cache 
      #
      # @param [Symbol] cache
      #   the cache to be used
      def [](cache)
        raise Exceptions::CacheDoesNotExist, "Unknown cache \":#{cache}\" given. Did you create it in advance?"  unless @caches.has_key?(cache)

        @caches[cache]
      end

      # Add a new cache
      #
      # @param [Symbol] cache
      #   the cache to be created
      #
      # @param [Symbol] strategy
      #   the cache strategy to be used
      def add(cache,strategy)
        raise Exceptions::UnknownCachingStrategy, "Unknown caching strategy \":#{strategy}\" given. Did you register it in advance?"  unless Cache.caching_strategies.has_key?(strategy)

        @caches[cache.to_sym] = @caching_strategies[strategy.to_sym].new 
        @caches[cache]
      end
    end
  end
end
