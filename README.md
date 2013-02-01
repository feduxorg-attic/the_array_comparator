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
comparator = Comparator.new
data = %w{ a b c d}
keyword_overlap = %w{ a }
keyword_no_overlap = %w{ e }

comparator.add_probe data , :contains , keyword_overlap
comparator.add_probe data , :not_contains , keyword_no_overlap

result = comparator.success?
expect(result).to eq(false)

```

### Example with exceptions

```ruby
comparator = Comparator.new
data = %w{ ab c d}
keyword_overlap = %w{ a }
exceptions = %w{ ab }

comparator.add_probe data , :contains_substring , keyword_overlap
comparator.add_probe data , :not_contains_substring , keyword_overlap, exceptions

  result = comparator.success?
expect(result).to eq(true)
```

### Extend the library

If you wish to write your own comparators you can do so. Just register those classes with a keyword.

```ruby
Comparator.register :contains, Strategies::Contains
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
