# the main module
module TheArrayComparator
  # the main comparator shell class
  class Comparator

    # VARIABLE to store strategies
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
        @comparators ||= {}

        if klass.respond_to?(:add_check) and klass.new.respond_to?(:success?)
          @comparators[name.to_sym] = klass
        else
          raise Exceptions::IncompatibleComparator, "Registering #{klass} failed. It does not support \"add_check\"-class- and \"success?\"-instance-method"
        end
      end
    end

    # Create a new comparator instance
    # and register default comparators
    #
    # @return [Comparator]
    #   a new comparator
    def initialize
      @checks = []
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
    # @param [Array] exceptions (optional)
    #   exception, should not be considered as match
    #
    # @raise [Exceptions::UnknownProbeType]
    #   if a unknown strategy is given (needs to be registered first)
    def add_check(data,type,keywords,options={})
      raise Exceptions::UnknownProbeType, "Unknown check type \":#{type}\" given. Did you register it in advance?" unless Comparator.comparators.has_key?(type)
      opts = {
        exceptions: [],
        tag:'',
      }.merge options

      sample = Sample.new(data,keywords,opts[:exceptions],opts[:tag])
      check = Comparator.comparators[type].add_check(sample)
      @checks << check

      return check
    end

    def result
      @checks.each { |c| return [ false , c ] unless c.success? }

      [ true ]
    end

    # Run all checks
    #
    # @return [TrueClass, FalseClass]
    #   the result of all checks. if at least one fails the result will be
    #   'false'. If all are true, the result will be true.
    def success?
      result.shift
    end

    # Delete check
    #
    # @param [Integer] number
    #   the index of the check which should be deleted
    def delete_check(number)
      if @checks[number]
        @checks.delete_at(number) 
      else
        raise Exceptions::ProbeDoesNotExist, "You tried to delete a check, which does not exist!"
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
      @checks
    end
  end
end
