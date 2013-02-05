#enconding: utf-8
require 'spec_helper'

describe Sample do
  it "takes data, keywords, exceptions, tags" do
    expect {
      Sample.new()
    }.to raise_error

  end
end
