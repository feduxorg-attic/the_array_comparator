# The Array Comparator

[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/maxmeyer/the_array_comparator)
[![Build Status](https://travis-ci.org/maxmeyer/the_array_comparator.png?branch=master)](https://travis-ci.org/maxmeyer/the_array_comparator)


The Array Comparator lets you add multiple checks comparing two arrays each.
This way it lets you write more concise tests and makes error detection in a
commandline environment a lot easier -- [Use Cases](#use_cases). If you're
interested, please have a look at the <a
href="http://www.github.com/maxmeyer/the_array_comparator">git repository</a>.



It also supports caching of previous comparism runs to reduce the amount of
time for each subsequent run - if no further check was added.

## Installation

Add this line to your application's Gemfile:

    gem 'the_array_comparator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install the_array_comparator

## Usage

Currently the following strategies are supported
<table>
  <caption>Supported search strategies for checks</caption>
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

To add a check you need to use `#add_check`-method. It accepts four arguments
* `data`: The data which should be searched
* `strategy`: The kind of check which should be added (see the table above for supported strategies)
* `keywords`: The keywords which should be looked up in data
* `options` (optional): Options for the check to be added (see the table below for valid options)

```ruby
comparator.add_check data , operation, keywords, options
```

<table>
  <caption>Supported options for check</caption>
  <tr>
    <th>Option</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>:tag</td>
    <td>If you need to know which check caused the test suite to fail, add a
    tag to the check. The array comparator records the sample which fails the
    whole test suite. You can use *whatever* you want/can imagine as a tag:
    e.g. `String`, `Symbol`. Personally I prefer to use `Symbol`s.</td> 
   </tr>
  <tr>
    <td>:exceptions</td>
    <td>Some times you have a quite generic check which matches to many lines
    in the sample. To help you with that, you can add an exception to a
    check.</td> 
  </tr>
</table>

```ruby
comparator.add_check data , operation, keywords, tag: :test_tag, exceptions: [ 'lala' ]
```

If you ask the comparator for success before a check was added, it will return
`true`. If you ask it for the `#failed_sample` it will return an empty result
to you.

### Simple example

```ruby
require 'the_array_comparator'
comparator = TheArrayComparator::Comparator.new
data = %w{ a b c d }
keyword_overlap = %w{ a b }

comparator.add_check data , :contains_all , keyword_overlap

result = comparator.success?
puts result #should be true
```

### Example with substrings

```ruby
require 'the_array_comparator'
comparator = TheArrayComparator::Comparator.new
data = %w{ acd b }
keyword_overlap = %w{ cd b }

comparator.add_check data , :contains_all_as_substring, keyword_overlap 

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

comparator.add_check data , :contains_all_as_substring, keyword_overlap, exceptions: exceptions

result = comparator.success?
puts result #should be false
```

### Example with multiple checks

```ruby
require 'the_array_comparator'
comparator = TheArrayComparator::Comparator.new

data = %w{ acd b }
keyword_overlap = %w{ a b }
comparator.add_check data , :contains_all_as_substring, keyword_overlap

data = %w{1 2 3 4}
keywords = %w{ a b }
comparator.add_check data , :not_contains, keywords

result = comparator.success?
puts result #should be true
```

### Example with tag

```ruby
#simple, isn't it?
require 'the_array_comparator'
comparator = TheArrayComparator::Comparator.new
data = %w{ a b c d }
keyword_successfull = %w{ a b }
keyword_failed = %w{ e }

comparator.add_check data , :contains_all , keyword_successfull
#comparator.add_check data , :contains_all , keyword_failed, tag: :this_is_another_tag
comparator.add_check data , :contains_all , keyword_failed, tag: 'this is a failed sample'

comparator.success?
puts comparator.result.failed_sample.tag

#use WHATEVER you want!
require 'the_array_comparator'
require 'ostruct'
comparator = TheArrayComparator::Comparator.new
data = %w{ a b c d }
keyword_successfull = %w{ a b }
keyword_failed = %w{ e }

comparator.add_check data , :contains_all , keyword_successfull
comparator.add_check data , :contains_all , keyword_failed, tag: OpenStruct.new( id: 1, text: 'this is another tag as well' )

comparator.success?
puts comparator.result.failed_sample.tag.text
```

### Example with access to result
```ruby
require 'the_array_comparator'
comparator = TheArrayComparator::Comparator.new

data = %w{ a c d b }
keyword_overlap = %w{ a b }
comparator.add_check data , :not_contains, keyword_overlap

p comparator.success? 
p comparator.result.of_checks
p comparator.result.failed_sample
```


### Extend the library

If you wish to write your own comparators you can do so. Just register those classes with a keyword.

```ruby
c = TheArrayComparator::Comparator.new
c.register :my_contains, SearchingStrategies::MyContains
```

##<a name=use_cases>Use Cases</a>

### Testing

```ruby
require 'the_array_comparator'
describe TheArrayComparator
  it "tells you the result of the check" do
    comparator = TheArrayComparator::Comparator.new
    data = %w{ a b c d }
    keyword_overlap = %w{ a b }
    keyword_no_overlap = %w{ e }
    
    comparator.add_check data , :contains_all , keyword_overlap
    comparator.add_check data , :not_contains , keyword_no_overlap
    
    expect(comparator.success?).to eq(true)
  end
end
```

### Error checking

```ruby
#!/usr/bin/env ruby

require 'open3'
require 'the_array_comparator'

stdout_str, stderr_str, status = Open3.capture3("/usr/bin/env echo error")

comparator = TheArrayComparator::Comparator.new
comparator.add_check stdout_str.split("\n") , :contains_all , %w[ error ]
comparator.add_check [ status.exitstatus ] , :contains_all , [ 0 ]

p comparator.success? #should be true
```

## Further reading

Please see the full api-documentation on [rdoc
info](http://rdoc.info/github/maxmeyer/the_array_comparator/frames) for further
reading. There's also a brief [guide](API-GUIDE.md) about howto discover the
API.

## Contributing

Please see [CONTRIBUTIONS.md](CONTRIBUTIONS.md).

## Copyright

(c) 2013 Max Meyer. All rights reserved. Please also see [LICENSE.md](LICENSE.md).
