# The Array Comparator

Can be used to compare to arrays with a consistent api.

## Installation

Add this line to your application's Gemfile:

    gem 'comparator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install comparator

## Usage

Currently the following strategies are supported
<table>
  <tr>
    <th>Strategy</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>:contains_all</td>
    <td>True if all of the given keywords are part of the data</td>
  </tr>
  <tr>
    <td>:contains_any</td>
    <td>True if any of the given keywords are part of the data</td>
  </tr>
  <tr>
    <td>:not_contains</td>
    <td>True if the given keywords are not part of the data</td>
  </tr>
  <tr>
    <td>:contains_all_as_substring</td>
    <td>True if all given keywords are a substring of an data element</td>
  </tr>
  <tr>
    <td>:contains_any_as_substring</td>
    <td>True if any given keyword are a substring of an data element</td>
  </tr>
  <tr>
    <td>:not_contains_substring</td>
    <td>True if none of the given keywords is a substring of an data element</td>
  </tr>
  <tr>
    <td>:is_equal</td>
    <td>True if both, the keywords and the data, are identical</td>
  </tr>
  <tr>
    <td>:is_not_equal</td>
    <td>True if the keywords are didfferent from the data</td>
  </tr>
</table>

### Simple example

```ruby
require 'the_array_comparator'
comparator = TheArrayComparator::Comparator.new
data = %w{ a b c d }
keyword_overlap = %w{ a b }

comparator.add_probe data , :contains_all , keyword_overlap

result = comparator.success?
puts result #should be true
```

### Example with substrings

```ruby
require 'the_array_comparator'
comparator = TheArrayComparator::Comparator.new
data = %w{ acd b }
keyword_overlap = %w{ cd b }

comparator.add_probe data , :contains_all_as_substring, keyword_overlap 

result = comparator.success?
puts result #should be true
```

### Example with exceptions

```ruby
require 'the_array_comparator'
comparator = TheArrayComparator::Comparator.new
data = %w{ acd b }
keyword_overlap = %w{ a b }
exceptions = %w{ cd }

comparator.add_probe data , :contains_all_as_substring, keyword_overlap, exceptions

result = comparator.success?
puts result #should be false
```

### Extend the library

If you wish to write your own comparators you can do so. Just register those classes with a keyword.

```ruby
TheArrayComparator::Comparator.register :my_contains, Strategies::MyContains
```

## Contributing

Please see CONTRIBUTIONS.md

## Copyright

(c) 2013 Max Meyer. All rights reserved. Please also see LICENSE.md
