require 'rake'
require 'rake_performance'
require 'find'
require 'fileutils'
require "bundler/setup"

# always destroy the kitchen when running within Teamcity
destroy_strategy = ENV['TEAMCITY_VERSION'] ? 'always' : 'passing'

namespace :acceptance do
  desc 'Install puppet modules from Puppetfile'
  task :installpuppetmodules do
    sh "bundle exec r10k puppetfile install --verbose"
  end

  desc 'Execute the acceptance tests'
  task :kitchen => [:installpuppetmodules] do |task, args|
    begin
      sh "kitchen test --destroy=#{destroy_strategy} --concurrency --log-level=info"
    ensure
      puts "##teamcity[publishArtifacts '#{Dir.pwd}/.kitchen/logs/*.log => logs.zip']"
    end
  end

end

namespace :check do
  namespace :manifests do
    desc 'Validate syntax for all manifests'
    task :syntax do
      Dir.glob('**/*.pp').each do |puppet_file|
        Bundler.with_clean_env  do
          # Use bundler.with_clean_env as the way bundler set ruby environment variables
          # is killing puppet on windows.
          # Note that we may instead want to add puppet to our Gemfiles but we are currently seeing
          # gem dependency conflicts between test-kitchen and puppet...
          # Since we already have puppet installed on our build/test agents, let's use it.
          sh "puppet parser validate #{puppet_file}"
        end
      end
    end

    require 'puppet-lint/tasks/puppet-lint'
    Rake::Task[:lint].clear
    desc 'puppet-lint all the manifests'
    PuppetLint::RakeTask.new :lint do |config|
      # # Pattern of files to ignore
      # config.ignore_paths = ['modules/apt', 'modules/stdlib']

      # List of checks to disable
      config.disable_checks = ['80chars', 'trailing_whitespace', '2sp_soft_tabs', 'hard_tabs']

      # # Enable automatic fixing of problems, defaults to false
      # config.fix = true
    end
  end

  namespace :ruby do
    desc 'Validate syntax for all ruby files'
    task :syntax do
      Dir.glob('**/*.rb').each do |ruby_file|
        sh "ruby -c #{ruby_file}"
      end
      Dir.glob('**/*.erb').each do |erb_file|
        sh "erb -P -x -T '-' #{erb_file} | ruby -c"
      end
    end
  end

end

task :checks => ['check:manifests:syntax', 'check:manifests:lint', 'check:ruby:syntax']
task :default => :checks
