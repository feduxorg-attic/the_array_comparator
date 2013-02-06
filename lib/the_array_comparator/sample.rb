# the main module
module TheArrayComparator
  # class holding the data for the comparism
  class Sample
    # @!attribute [rw] keywords
    #   data used to search in other data set
    #
    # @!attribute [rw] data
    #   test data
    #
    # @!attribute [rw] exceptions
    #   exceptions from data search
    #
    # @!attribute [rw] tag
    #   description of the probe
    attr_accessor :data, :keywords, :exceptions, :tag

    def initialize(data=[],keywords=[],exceptions=[],tag=nil)
      @keywords = keywords
      @data = data
      @exceptions = exceptions
      @tag = tag
    end

  end
end
