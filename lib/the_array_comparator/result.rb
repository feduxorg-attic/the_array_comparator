#encoding: utf-8

# the main module
module TheArrayComparator
  # the check result
  class Result
    def initialize(sample=nil)
      @sample = sample
    end

    def of_checks
      return true if @sample.blank?
      false
    end

    def failed_sample
      @sample || null_sample
    end

    private

    def null_sample
      Sample.new
    end

  end
end
