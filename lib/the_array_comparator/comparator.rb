#encoding: utf-8
require 'the_array_comparator/caching_strategies/anonymous_cache'
require 'the_array_comparator/caching_strategies/single_value_cache'

# the main module
module TheArrayComparator
  # the main comparator shell class
  class Comparator < StrategyDispatcher

    strategy_reader :comparators

    # Create a new comparator instance
    # and register default comparators
    #
    # @return [Comparator]
    #   a new comparator
    def initialize(cache=Cache.new)
      super()

      @cache = cache
      @cache.add(:checks, :anonymous_cache)
      @cache.add(:result, :single_value_cache)

      register :contains_all, SearchingStrategies::ContainsAll
      register :contains_any, SearchingStrategies::ContainsAny
      register :not_contains, SearchingStrategies::ContainsNot
      register :contains_all_as_substring, SearchingStrategies::ContainsAllWithSubstringSearch
      register :contains_any_as_substring, SearchingStrategies::ContainsAnyWithSubstringSearch
      register :not_contains_substring, SearchingStrategies::ContainsNotWithSubstringSearch
      register :is_equal, SearchingStrategies::IsEqual
      register :is_not_equal, SearchingStrategies::IsNotEqual

      @result = Result.new
    end

    # @see StrategyWrapper
    def exception_invalid_strategy
      Exceptions::IncompatibleComparator
    end

    # @see StrategyWrapper
    def class_must_have_methods
      [
        :success?,
      ]
    end

    # Add a check to test against
    #
    # @param [Array] data
    #   the data which should be used as check, will be passed to the concrete comparator strategy
    #
    # @param [Symbol] type
    #   the comparator strategy (needs to be registered first)
    #
    # @param [Array] keywords
    #   what to look for in the data, will be passed to the concrete comparator strategy
    #
    # @param [Hash] options 
    #   exception, should not be considered as match
    #
    # @option options [Hash] exceptions
    #   the exceptions from keywords
    #
    # @option options [String] tag
    #   a tag to identify the check
    #
    # @raise [Exceptions::UnknownCheckType]
    #   if a unknown strategy is given (needs to be registered first)
    def add_check(data,type,keywords,options={})
      t = type.to_sym

      raise Exceptions::UnknownCheckType, "Unknown check type \":#{t}\" given. Did you register it in advance?" unless comparators.has_key?(t)
      opts = {
        exceptions: [],
        tag:'',
      }.merge options

      sample = Sample.new(data,keywords,opts[:exceptions],opts[:tag])
      strategy_klass = comparators[t]
      check = Check.new(strategy_klass,sample)

      @cache[:checks].add check
    end

    # The result of all checks defined
    #
    # @return [Result] 
    #   the result class with all the data need for further analysis
    def result
      if @cache[:checks].new_objects?
        @cache[:checks].stored_objects.each do |c| 
          @result = Result.new(c.sample) unless c.success?
        end
      end

      @result
    end

    # Run all checks
    #
    # @return [TrueClass, FalseClass]
    #   the result of all checks. if at least one fails the result will be
    #   'false'. If all are true, the result will be true.
    def success?
      result.of_checks
    end

    # Delete check
    #
    # @param [Integer] number
    #   the index of the check which should be deleted
    def delete_check(number)
      if @cache[:checks].fetch_object(number)
        @cache[:checks].delete_object(number) 
      else
        raise Exceptions::CheckDoesNotExist, "You tried to delete a check, which does not exist!"
      end
    end

    # Delete the last check added
    def delete_last_check
      delete_check(-1)
    end

    # List all added checks
    #
    # @return [Array]
    #   all available checks
    def list_checks
      @cache[:checks].stored_objects
    end
  end
end
