# Sample
class SampleDouble
  attr_accessor :data, :keywords, :exceptions, :tag

  def initialize(data = [], keywords = [], exceptions = [], tag = nil)
    @keywords = keywords
    @data = data
    @exceptions = exceptions
    @tag = tag
  end
end
