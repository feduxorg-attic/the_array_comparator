#!/usr/bin/env rake

require 'fedux_org_stdlib/rake_tasks/gems'
require 'fedux_org_stdlib/rake_tasks/software_version/bump'

desc 'Run test suite'
task test: ['test:rspec', 'test:rubocop']

namespace :coveralls do
  task :push do
    sh 'bundle exec coveralls push'
  end
end

namespace :test do
  desc 'Test with coveralls'
  task coveralls: ['test', 'coveralls:push']

  task :rubocop do
    sh 'bundle exec rubocop'
  end

  task 'rubocop:autocorrect' do
    sh 'bundle exec rubocop --auto-correct'
  end

  desc 'Run rspec'
  task :rspec do
    sh 'bundle exec rspec'
  end

  desc 'Run mutant'
  task :mutant do
    sh 'mutant --include lib --require middleman-presentation --use rspec "Middleman::Presentation*"'
  end
end

namespace :gem do
  desc 'Clean build packages'
  task :clean do
    FileUtils.rm Dir.glob(File.join(pkg_directory, '*.gem'))
  end
end
