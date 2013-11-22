#enconding: utf-8
require 'spec_helper'

describe Comparator do
  cache_klass = Class.new do
    def success?
      true
    end

    def initialize(sample=nil)
    end
  end

  it "let you add check to check for" do
    testrun = Comparator.new
    data = %w{ a b c d}
    keyword = %w{ a }

    expect {
      testrun.add_check data , :contains_all , keyword
    }.to_not raise_error
  end

  it "fails if an unknown check is given" do
    testrun = Comparator.new
    data = %w{ a b c d}
    keyword = %w{ a }

    expect {
      testrun.add_check data , :contains_all_abc , keyword
    }.to raise_error Exceptions::UnknownCheckType
  end

  it "support some comparators by default" do
    testrun = Comparator.new
    data = %w{ a b c d}
    keyword = %w{ a }

    expect {
      testrun.add_check data , :contains_all , keyword
      testrun.add_check data , :contains_any , keyword
      testrun.add_check data , :not_contains , keyword
      testrun.add_check data , :contains_all_as_substring , keyword
      testrun.add_check data , :contains_any_as_substring , keyword
      testrun.add_check data , :not_contains_substring , keyword
      testrun.add_check data , :is_equal , keyword
      testrun.add_check data , :is_not_equal , keyword
    }.to_not raise_error
  end

  it "is successfull if all subtests are successfull" do
    comparator = Comparator.new
    data = %w{ a b c d }
    keyword_overlap = %w{ a b }
    keyword_no_overlap = %w{ e }

    comparator.add_check data , :contains_all , keyword_overlap
    comparator.add_check data , :not_contains , keyword_no_overlap

    result = comparator.success?
    expect(result).to eq(true)
  end
  
  it "fails if a least one subtest fails" do
    comparator = Comparator.new
    data = %w{ a b c d }
    keyword_overlap = %w{ a }
    keyword_no_overlap = %w{ e }

    comparator.add_check data , :contains_all , keyword_overlap #should not fail
    comparator.add_check data , :not_contains , keyword_overlap #should fail

    result = comparator.success?
    expect(result).to eq(false)
  end

  it "supports the addition of exceptions as well" do
    comparator = Comparator.new
    data = %w{ ab c d}
    keyword_overlap = %w{ a }
    exceptions = %w{ ab }

    comparator.add_check data , :contains_any_as_substring , keyword_overlap
    comparator.add_check data , :not_contains_substring , keyword_overlap, :exceptions => exceptions

    result = comparator.success?
    expect(result).to eq(true)
  end

  it "list all added check" do
    comparator = Comparator.new
    data = []
    keywords = []

    check = comparator.add_check data , :contains_any, keywords
    list = comparator.list_checks.first

    expect(list).to eq(check)
  end

  it "deletes the n-th check" do
    comparator = Comparator.new
    data = []
    keywords = []

    test_comps = []

    test_comps << comparator.add_check(data , :contains_any, keywords)
    comparator.add_check(data , :contains_any, keywords)
    test_comps << comparator.add_check(data , :contains_any, keywords)
    comparator.delete_check(1)

    list = comparator.list_checks
    expect(list).to eq(test_comps)
  end

  it "raises an error if a user tries to delete an unexisting check" do
    comparator = Comparator.new

    expect {
      comparator.delete_last_check
    }.to raise_error Exceptions::CheckDoesNotExist
  end

  it "deletes the last check" do
    comparator = Comparator.new
    data = []
    keywords = []

    test_comps = []

    test_comps << comparator.add_check(data , :contains_any, keywords)
    test_comps << comparator.add_check(data , :contains_any, keywords)
    comparator.add_check(data , :contains_any, keywords)
    comparator.delete_last_check

    list = comparator.list_checks
    expect(list).to eq(test_comps)
  end

  it "tells you the result of the check" do
    comparator = Comparator.new
    data = %w{ a b c d }
    keyword_overlap = %w{ a b }
    keyword_no_overlap = %w{ e }

    comparator.add_check data , :contains_all , keyword_overlap
    comparator.add_check data , :not_contains , keyword_no_overlap

    comparator.success?
    result = comparator.result
    expect(result.of_checks).to eq(true)
  end

  it "tells you which check has failed and made the whole thing failed" do
    comparator = Comparator.new
    data = %w{ a b c d }
    keyword_successfull = %w{ a b }
    keyword_failed = %w{ e }

    comparator.add_check data , :contains_all , keyword_successfull
    c = comparator.add_check data , :contains_all , keyword_failed, tag: 'this is a failed sample'

    comparator.success?
    result = comparator.result
    expect(result.failed_sample).to eq(c.sample)
  end

  it "tells you the result of the check although no checks were added" do
    comparator = Comparator.new
    comparator.success?
    result = comparator.result
    expect( comparator.success? ).to eq(true)
  end

  it "returns an empty result if no checks were added but it is asked for a result" do
    comparator = Comparator.new
    comparator.success?

    result = comparator.result
    expect(result.failed_sample).to be_blank
  end
end
