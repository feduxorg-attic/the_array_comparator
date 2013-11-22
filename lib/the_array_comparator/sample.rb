#encoding: utf-8

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

    # New sample
    #
    # @param [Array] data ([])
    #  the data to look for keywords
    #
    # @param [Set] keywords (Set.new)
    #   the keywords (singular values/arrays will be transformed to a set)
    #
    # @param [Set] exceptions (Set.new)
    #   the exceptions  (singular values/arrays will be transformed to a set)
    #
    # @param [String] tag (nil)
    #   a tag to identify a sample
    def initialize(data=[],keywords=Set.new,exceptions=Set.new,tag=nil)
      @keywords = Set.new( [ *keywords ] )
      @data = *data
      @exceptions = Set.new( [ *exceptions ] )
      @tag = tag
    end

    # Check if sample is blank: no values for keywords, data, exceptions, tag
    #
    # @return [true,false] the result of check
    def blank?
      @keywords.blank? and @data.blank? and @exceptions.blank? and @tag.blank?
    end
  end
end
