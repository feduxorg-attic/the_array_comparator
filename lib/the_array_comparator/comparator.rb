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

        if klass.respond_to?(:add_probe) and klass.new.respond_to?(:success?)
          @comparators[name.to_sym] = klass
        else
          raise Exceptions::IncompatibleComparator, "Registering #{klass} failed. It does not support \"add_probe\"-class- and \"success?\"-instance-method"
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

    # Add a probe to test against
    #
    # @param [Array] data
    #   the data which should be used as probe, will be passed to the concrete comparator strategy
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
    def add_probe(data,type,keywords,options={})
      raise Exceptions::UnknownProbeType, "Unknown probe type \":#{type}\" given. Did you register it in advance?" unless Comparator.comparators.has_key?(type)
      opts = {
        exceptions: [],
        tag:'',
      }.merge options

      sample = Sample.new(data,keywords,opts[:exceptions],opts[:tag])
      check = Comparator.comparators[type].add_probe(sample)
      @checks << check

      return check
    end

    def result
      @checks.each { |c| return [ false , c ] unless c.success? }

      [ true ]
    end

    # Run all probes
    #
    # @return [TrueClass, FalseClass]
    #   the result of all probes. if at least one fails the result will be
    #   'false'. If all are true, the result will be true.
    def success?
      result.shift
    end

    # Delete probe
    #
    # @param [Integer] number
    #   the index of the probe which should be deleted
    def delete_probe(number)
      if @checks[number]
        @checks.delete_at(number) 
      else
        raise Exceptions::ProbeDoesNotExist, "You tried to delete a probe, which does not exist!"
      end
    end

    # Delete the last probe added
    def delete_last_probe
      delete_probe(-1)
    end

    # List all added probes
    #
    # @return [Array]
    #   all available probes
    def list_probes
      @checks
    end
  end
end
