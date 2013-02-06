class SampleDouble < Struct.new(:keywords,:data,:exceptions,:tag)
  def initialize(keywords=[],data=[],exceptions=[],tag=nil)
    @keywords = keywords
    @data = data
    @exceptions = exceptions
    @tag = tag
  end
end
