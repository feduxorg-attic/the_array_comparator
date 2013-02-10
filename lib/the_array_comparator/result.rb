#encoding: utf-8

# the main module
module TheArrayComparator
  # the check result
  class Result
    def initialize(sample=nil)
      @sample = sample
    end

    def from_check
      return true if @sample.blank?
      false
    end

    def failed_sample
      @sample
    end

  end
end
