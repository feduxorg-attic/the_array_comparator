#encoding: utf-8

require 'active_support/core_ext/object/blank'
require 'set'
require 'forwardable'

require 'the_array_comparator/version'
require 'the_array_comparator/exceptions'
require 'the_array_comparator/sample'
require 'the_array_comparator/check'
require 'the_array_comparator/result'
require 'the_array_comparator/strategy_dispatcher'
require 'the_array_comparator/caching_strategies/anonymous_cache'
require 'the_array_comparator/caching_strategies/single_value_cache'
require 'the_array_comparator/cache'
require 'the_array_comparator/searching_strategies/base'
require 'the_array_comparator/searching_strategies/contains_all_with_substring_search'
require 'the_array_comparator/searching_strategies/contains_any_with_substring_search'
require 'the_array_comparator/searching_strategies/contains_all'
require 'the_array_comparator/searching_strategies/contains_any'
require 'the_array_comparator/searching_strategies/contains_not_with_substring_search'
require 'the_array_comparator/searching_strategies/contains_not'
require 'the_array_comparator/searching_strategies/is_equal'
require 'the_array_comparator/searching_strategies/is_not_equal'
require 'the_array_comparator/comparator'


# main module
module TheArrayComparator
  #Comparator.register :contains_all, SearchingStrategies::ContainsAll
  #Comparator.register :contains_any, SearchingStrategies::ContainsAny
  #Comparator.register :not_contains, SearchingStrategies::ContainsNot
  #Comparator.register :contains_all_as_substring, SearchingStrategies::ContainsAllWithSubstringSearch
  #Comparator.register :contains_any_as_substring, SearchingStrategies::ContainsAnyWithSubstringSearch
  #Comparator.register :not_contains_substring, SearchingStrategies::ContainsNotWithSubstringSearch
  #Comparator.register :is_equal, SearchingStrategies::IsEqual
  #Comparator.register :is_not_equal, SearchingStrategies::IsNotEqual

  #Cache.register :anonymous_cache, CachingStrategies::AnonymousCache
  #Cache.register :single_value_cache, CachingStrategies::SingleValueCache
end
