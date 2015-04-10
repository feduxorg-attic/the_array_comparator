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
      expect(sample.keywords).to eq(Set.new(keywords))
      expect(sample.exceptions).to eq(Set.new(exceptions))
      expect(sample.tag).to eq(tag)
  end

  it "takes singular values and return them into arrays" do
      data = 'data'
      keywords = 'keywords'
      exceptions = 'exceptions'

      sample = Sample.new(data, keywords, exceptions)

      expect(sample.data).to eq([ data ])
      expect(sample.keywords).to eq(Set.new( [ keywords ] ) )
      expect(sample.exceptions).to eq(Set.new( [ exceptions ] ) )
  end

  context '#blank' do
    it "checks if all values are blank" do
      expect( Sample.new.blank? ).to be true
    end
  end

end
