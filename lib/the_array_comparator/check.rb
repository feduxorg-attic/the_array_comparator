#encoding: utf-8

# the main module
module TheArrayComparator
  # the check result
  class Check
    extend Forwardable

    # Delegates success? to check
    def_delegator :@check, :success?

    # Creates new check
    def initialize(strategy_klass,sample)
      @check = strategy_klass.new(sample)
    end

    # Checks for success
    def success?
      @check.success?
    end

    # Checks for failure
    def failed?
      not success?
    end


  end
end
