# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'the_array_comparator/version'

Gem::Specification.new do |gem|
  gem.name          = 'the_array_comparator'
  gem.version       = TheArrayComparator::VERSION
  gem.authors       = ['Max Meyer']
  gem.email         = ['dev@fedux.org']
  gem.description   = 'you need to compare arrays? then this gem is very suitable for you.'
  gem.summary   = 'you need to compare arrays? then this gem is very suitable for you.'
  gem.homepage      = 'https://www.github.com/maxmeyer/the_array_comparator'

  gem.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'activesupport'
end
