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

        must_have_methods = [
          :add,
          :clear,
          :stored_objects,
          :delete_objects,
          :new_objects?,
          :fetch_object,
        ]

        if must_have_methods.all? { |m| klass.new.respond_to?(m) }
          @caching_strategies[name.to_sym] = klass
        else
          raise Exceptions::IncompatibleCachingStrategy, "Registering #{klass} failed. It does not support #{must_have_methods.join("-, ")}-instance-methods"
        end
      end

      # Retrieve cache 
      #
      # @param [Symbol] cache
      #   the cache to be used
      def [](cache)
        return @caches[cache] if @caches.has_key(cache)

        nil
      end

      # Create new cache
      #
      # @param [Symbol] cache
      #   the cache to be created
      #
      # @param [Cache] strategy
      #   the cache strategy to be used
      def new(cache,strategy=AnonymousCache)
        @caches[cache] = strategy.new
      end
    end

  end
end
