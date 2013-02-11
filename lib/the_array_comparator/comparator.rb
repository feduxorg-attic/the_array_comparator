#encoding: utf-8

# the main module
module TheArrayComparator
  # the main comparator shell class
  class Comparator

    # Variable to store strategies
    @comparators = {}
    class << self

      # @!attribute [rw] command
      #   Return all available comparator strategies
      attr_accessor :comparators

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
        if klass.new.respond_to?(:success?)
          @comparators[name.to_sym] = klass
        else
          raise Exceptions::IncompatibleComparator, "Registering #{klass} failed. It does not support \"success?\"-instance-method"
        end
      end
    end

    # Create a new comparator instance
    # and register default comparators
    #
    # @return [Comparator]
    #   a new comparator
    def initialize(cache_checks=[],cache_result=[])
      Cache.add(:checks, :anonymous_cache)
      Cache.add(:result, :single_value_cache)
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
      raise Exceptions::UnknownCheckType, "Unknown check type \":#{type}\" given. Did you register it in advance?" unless Comparator.comparators.has_key?(type)
      opts = {
        exceptions: [],
        tag:'',
      }.merge options

      sample = Sample.new(data,keywords,opts[:exceptions],opts[:tag])
      strategy_klass = Comparator.comparators[type]
      check = Check.new(strategy_klass,sample)

      Cache[:checks].add check
    end

    # The result of all checks defined
    #
    # @return [Result] 
    #   the result class with all the data need for further analysis
    def result
      Cache[:checks].stored_objects.each { |c| return Result.new(c.sample) unless c.success? }

      Result.new
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
      if Cache[:checks].fetch_object(number)
        Cache[:checks].delete_object(number) 
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
      Cache[:checks].stored_objects
    end
  end
end
