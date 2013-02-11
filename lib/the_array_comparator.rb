#encoding: utf-8

require 'active_support/core_ext/object/blank'
require 'set'
require 'forwardable'

require 'the_array_comparator/version'
require 'the_array_comparator/exceptions'
require 'the_array_comparator/sample'
require 'the_array_comparator/check'
require 'the_array_comparator/result'
require 'the_array_comparator/cache/anonymous_cache'
require 'the_array_comparator/cache/single_value_cache'
require 'the_array_comparator/cache'
require 'the_array_comparator/strategies/base'
require 'the_array_comparator/strategies/contains_all_with_substring_search'
require 'the_array_comparator/strategies/contains_any_with_substring_search'
require 'the_array_comparator/strategies/contains_all'
require 'the_array_comparator/strategies/contains_any'
require 'the_array_comparator/strategies/contains_not_with_substring_search'
require 'the_array_comparator/strategies/contains_not'
require 'the_array_comparator/strategies/is_equal'
require 'the_array_comparator/strategies/is_not_equal'
require 'the_array_comparator/comparator'


# main module
module TheArrayComparator
  Comparator.register :contains_all, Strategies::ContainsAll
  Comparator.register :contains_any, Strategies::ContainsAny
  Comparator.register :not_contains, Strategies::ContainsNot
  Comparator.register :contains_all_as_substring, Strategies::ContainsAllWithSubstringSearch
  Comparator.register :contains_any_as_substring, Strategies::ContainsAnyWithSubstringSearch
  Comparator.register :not_contains_substring, Strategies::ContainsNotWithSubstringSearch
  Comparator.register :is_equal, Strategies::IsEqual
  Comparator.register :is_not_equal, Strategies::IsNotEqual
end
