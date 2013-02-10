#enconding: utf-8
require 'spec_helper'

describe Comparator do
  it "let you register classes" do
    comparator_instance = double('TestComparator')
    comparator_instance.stub(:success?).and_return(true)

    comparator_klass = double('TestComparator')
    comparator_klass.stub(:new).and_return(comparator_instance)
    comparator_klass.stub(:add_check).and_return(comparator_instance)

    expect {
      Comparator.register(:is_eqal_new, comparator_klass) 
    }.to_not raise_error
  end

  it "fails when registering a not suitable class" do
    comparator = double('TestComparator')
    comparator.stub(:sucessasdf).and_return(true)
    expect {
      Comparator.register(:is_eqal_new, comparator) 
    }.to raise_error
  end
  
  it "let you add check to check for" do
    testrun = Comparator.new
    data = %w{ a b c d}
    keyword = %w{ a }

    expect {
      testrun.add_check data , :contains_all , keyword
    }.to_not raise_error
  end

  it "let you register and use classes" do
    comparator_instance = double('TestComparator')
    comparator_instance.stub(:success?).and_return(true)

    comparator_klass = double('TestComparator')
    comparator_klass.stub(:new).and_return(comparator_instance)
    comparator_klass.stub(:add_check).and_return(comparator_instance)

    Comparator.register(:new_comp, comparator_klass) 

    comparator = Comparator.new
    comparator.add_check %w{a}, :new_comp , %{a}
    result = comparator.success?

    expect(result).to eq(true)
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
  
  it "fails if a least one subtest fails", :test => true do
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
    list = comparator.list_check.first

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
    }.to raise_error Exceptions::ProbeDoesNotExist
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
    expect(result.shift).to eq(true)
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
    expect(result.pop).to eq(c)
  end
end
