#encoding: utf-8

# the main module
module TheArrayComparator
  # the check result
  class Check
    extend Forwardable

    # Delegates success? to check
    def_delegator :@check, :success?

    # @!attribute [r]
    #   the sample of the check
    attr_reader :sample

    # Creates new check
    def initialize(strategy_klass,sample)
      @check = strategy_klass.new(sample)
      @sample = sample
    end

    # Checks for success
    def success?
      @check.success?
    end

  end
end
