require 'rubygems'
require 'open3'
require 'talks'

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'jquery-turbolinks/version'
 
namespace :gem do
  task :build do
    system 'gem build jquery-turbolinks.gemspec'
  end
  
  task release: :build do
    system "gem push jquery-turbolinks-#{Bunder::VERSION}"
  end
end

namespace :js do
  task :build do
    command = [
      './node_modules/coffee-script/bin/coffee',
      '--compile',
      '--output ./vendor/assets/javascripts/ ./src/jquery.turbolinks.coffee' 
    ]
    system command.join(' ')
  end
end

task :test do
 stdin, stdout, stderr = Open3.popen3 \
    './node_modules/mocha/bin/mocha ./spec/*_spec.coffee --compilers coffee:coffee-script -R spec -c'

  puts stdout_array = stdout.readlines
  puts stderr_array = stderr.readlines

  stdout_strings = stdout_array.to_s
  stderr_strings = stderr_array.to_s

  if stderr_strings and
    error_match = stderr_strings.match(/(\d+) of (\d+) (test[s]?) failed/)

    failed_count, total_count, tests_failed_str = error_match.captures

    message = "#{failed_count} of #{total_count} #{tests_failed_str} failed"

  elsif stdout_strings_match = stdout_strings.match(/(\d+) (test[s]?) complete/)
    complete_count, tests_complete_str = stdout_strings_match.captures

    if pending_matches = stdout_strings.match(/(\d+) test[s]? pending/)
      pending_count, tests_pending_str = pending_matches.captures
    end

    message = "#{complete_count} #{tests_complete_str} complete"
    message += ", #{pending_count} #{tests_pending_str} pending" if pending_count

  else
    message = 'Something wrong, check console output.'
  end

  `bundle exec terminal-notifier -message '#{message}' -title 'Test results' -remove TEST_RESULTS -group TEST_RESULTS`
  Talks.say message, detach: true
end
