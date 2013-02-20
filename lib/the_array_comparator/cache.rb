#encoding: utf-8

# the main module
module TheArrayComparator
  #caching class
  class Cache < StrategyDispatcher

    strategy_reader :caching_strategies

    # Variable to store available caches
    def initialize
      super()
      @caches = {}

      register :anonymous_cache, CachingStrategies::AnonymousCache
      register :single_value_cache, CachingStrategies::SingleValueCache
    end

    # @see [StrategyDispatcher]
    def class_must_have_methods
      [
        :add,
        :clear,
        :stored_objects,
        :new_objects?,
        :delete_object,
        :fetch_object,
      ]
    end

    # @see [StrategyDispatcher]
    def exception_to_raise_for_invalid_strategy
      Exceptions::IncompatibleCachingStrategy
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
      raise Exceptions::UnknownCachingStrategy, "Unknown caching strategy \":#{strategy}\" given. Did you register it in advance?"  unless caching_strategies.has_key?(strategy)

      @caches[cache.to_sym] = @caching_strategies[strategy.to_sym].new 
      @caches[cache]
    end
  end
end
