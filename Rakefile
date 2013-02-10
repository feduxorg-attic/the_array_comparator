#!/usr/bin/env rake

unless ENV['TRAVIS_CI'] == 'true'
  namespace :gem do
    require 'bundler/gem_tasks'
  end

  require 'yard'
  require 'rubygems/package_task'
  require 'active_support/core_ext/string/strip'
end

YARD::Rake::YardocTask.new do; end

desc 'start tmux'
task :terminal do
  sh "script/terminal"
end

task :term => :terminal
task :t => :terminal

namespace :version do
  version_file = Dir.glob('lib/**/version.rb').first

  desc 'bump version of library to new version'
  task :bump do

    new_version = ENV['VERSION'] || ENV['version']

    raw_module_name = File.open(version_file, "r").readlines.grep(/module/).first
    module_name = raw_module_name.chomp.match(/module\s+(\S+)/) {$1}

    version_string = %Q{#main #{module_name}
module #{module_name}
  VERSION = '#{new_version}'
end}

    File.open(version_file, "w") do |f|
      f.write version_string.strip_heredoc
    end

    sh "git add #{version_file}" 
    sh "git commit -m 'version bump to #{new_version}'" 
    project = 'the_array_comparator'
    sh "git tag #{project}-v#{new_version}" 
  end

  desc 'show version of library'
  task :show do
    raw_version = File.open(version_file, "r").readlines.grep(/VERSION/).first

    if raw_version
      version = raw_version.chomp.match(/VERSION\s+=\s+["']([^'"]+)["']/) { $1 }
      puts version
    else
      warn "Could not parse version file \"#{version_file}\""
    end

  end

  desc 'Restore version file from git repository'
  task :restore do
    sh "git checkout #{version_file}"
  end

end

namespace :travis do
  desc 'Runs travis-lint to check .travis.yml'
  task :check do
    sh 'travis-lint'
  end
end

namespace :test do
  desc 'Run specs'
  task :specs do
    sh 'bundle exec rspec spec'
  end

  desc 'Run tests in "travis mode"'
  task :travis_specs do
    ENV['TRAVIS_CI'] = 'true'
    sh 'rspec spec'
  end
end

task :console do
  sh 'script/console'
end
