# encoding: utf-8

# the main module
module TheArrayComparator
  # caching class
  class Cache < StrategyDispatcher
    strategy_reader :caching_strategies
    attr_reader :caches

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
        :fetch_object
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
      c = cache.to_sym

      fail Exceptions::CacheDoesNotExist, "Unknown cache \":#{c}\" given. Did you create it in advance?"  unless caches.key?(c)
      caches[c]
    end

    # Add a new cache
    #
    # @param [Symbol] cache
    #   the cache to be created
    #
    # @param [Symbol] strategy
    #   the cache strategy to be used
    def add(cache, strategy)
      c = cache.to_sym
      s = strategy.to_sym

      fail Exceptions::UnknownCachingStrategy, "Unknown caching strategy \":#{strategy}\" given. Did you register it in advance?"  unless caching_strategies.key?(strategy)

      caches[c] = caching_strategies[s].new
      caches[c]
    end
  end
end
