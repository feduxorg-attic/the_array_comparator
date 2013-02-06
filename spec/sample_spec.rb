#enconding: utf-8
require 'spec_helper'

describe Sample do
  it "takes nothing by default" do
    expect {
      Sample.new()
    }.to_not raise_error
  end

  it "takes data, keywords, exceptions, tags" do
      data = %w{ data }
      keywords = %w{ keywords }
      exceptions = %w{ exceptions }
      tag = 'this is a tag'

      sample = Sample.new(data, keywords, exceptions, tag)

      expect(sample.data).to eq(data)
      expect(sample.keywords).to eq(keywords)
      expect(sample.exceptions).to eq(exceptions)
      expect(sample.tag).to eq(tag)
  end
end
