require 'spec_helper'

describe Result do
  sample_klass = Class.new do
    attr_accessor :data, :keywords, :exceptions, :tag

    def initialize(data, keywords, exceptions, tag)
      @data = data
      @keywords = keywords
      @exceptions = exceptions
      @tag = tag
    end
  end

  it 'returns true if _no_ sample is defined' do
    result = Result.new
    expect(result.of_checks).to eq(true)
  end

  it 'returns false if sample is defined' do
    data = %w(data)
    keywords = %w(keywords)
    exceptions = %w(exceptions)
    tag = 'this is a tag'
    sample = sample_klass.new(data, keywords, exceptions, tag)

    result = Result.new(sample)
    expect(result.of_checks).to eq(false)
  end
end
