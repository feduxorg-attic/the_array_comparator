#enconding: utf-8
require 'spec_helper'

describe Comparator do
  it "let you register classes" do
    comparator_instance = double('TestComparator')
    comparator_instance.stub(:success?).and_return(true)

    comparator_klass = double('TestComparator')
    comparator_klass.stub(:new).and_return(comparator_instance)
    comparator_klass.stub(:add_probe).and_return(comparator_instance)

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
  
  it "let you add probes to check for" do
    testrun = Comparator.new
    data = %w{ a b c d}
    keyword = %w{ a }

    expect {
      testrun.add_probe data , :contains_all , keyword
    }.to_not raise_error
  end

  it "let you register and use classes" do
    comparator_instance = double('TestComparator')
    comparator_instance.stub(:success?).and_return(true)

    comparator_klass = double('TestComparator')
    comparator_klass.stub(:new).and_return(comparator_instance)
    comparator_klass.stub(:add_probe).and_return(comparator_instance)

    Comparator.register(:new_comp, comparator_klass) 

    comparator = Comparator.new
    comparator.add_probe %w{a}, :new_comp , %{a}
    result = comparator.success?

    expect(result).to eq(true)
  end

  it "support some comparators by default" do
    testrun = Comparator.new
    data = %w{ a b c d}
    keyword = %w{ a }

    expect {
      testrun.add_probe data , :contains_all , keyword
      testrun.add_probe data , :contains_any , keyword
      testrun.add_probe data , :not_contains , keyword
      testrun.add_probe data , :contains_all_as_substring , keyword
      testrun.add_probe data , :contains_any_as_substring , keyword
      testrun.add_probe data , :not_contains_substring , keyword
      testrun.add_probe data , :is_equal , keyword
      testrun.add_probe data , :is_not_equal , keyword
    }.to_not raise_error
  end

  it "is successfull if all subtests are successfull" do
    comparator = Comparator.new
    data = %w{ a b c d }
    keyword_overlap = %w{ a b }
    keyword_no_overlap = %w{ e }

    comparator.add_probe data , :contains_all , keyword_overlap
    comparator.add_probe data , :not_contains , keyword_no_overlap

    result = comparator.success?
    expect(result).to eq(true)
  end
  
  it "fails if a least one subtest fails", :test => true do
    comparator = Comparator.new
    data = %w{ a b c d }
    keyword_overlap = %w{ a }
    keyword_no_overlap = %w{ e }

    comparator.add_probe data , :contains_all , keyword_overlap #should not fail
    comparator.add_probe data , :not_contains , keyword_overlap #should fail

    result = comparator.success?
    expect(result).to eq(false)
  end

  it "supports the addition of exceptions as well" do
    comparator = Comparator.new
    data = %w{ ab c d}
    keyword_overlap = %w{ a }
    exceptions = %w{ ab }

    comparator.add_probe data , :contains_any_as_substring , keyword_overlap
    comparator.add_probe data , :not_contains_substring , keyword_overlap, exceptions

    result = comparator.success?
    expect(result).to eq(true)
  end

  it "list all added probes" do
    comparator = Comparator.new
    data = []
    keywords = []

    probe = comparator.add_probe data , :contains_any, keywords
    list = comparator.list_probes.first

    expect(list).to eq(probe)
  end

  it "deletes the n-th probe" do
    comparator = Comparator.new
    data = []
    keywords = []

    test_comps = []

    test_comps << comparator.add_probe(data , :contains_any, keywords)
    comparator.add_probe(data , :contains_any, keywords)
    test_comps << comparator.add_probe(data , :contains_any, keywords)
    comparator.delete_probe(1)

    list = comparator.list_probes
    expect(list).to eq(test_comps)
  end

  it "raises an error if a user tries to delete an unexisting probe" do
    comparator = Comparator.new

    expect {
      comparator.delete_last_probe
    }.to raise_error Exceptions::ProbeDoesNotExist
  end

  it "deletes the last probe" do
    comparator = Comparator.new
    data = []
    keywords = []

    test_comps = []

    test_comps << comparator.add_probe(data , :contains_any, keywords)
    test_comps << comparator.add_probe(data , :contains_any, keywords)
    comparator.add_probe(data , :contains_any, keywords)
    comparator.delete_last_probe

    list = comparator.list_probes
    expect(list).to eq(test_comps)
  end
end
