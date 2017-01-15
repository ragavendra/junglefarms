require 'active_support/core_ext/string/inflections'

require_relative '../setup'

require 'fixtures/liquid_loan'
require 'objects/test'
require 'objects/liquid_loan'
require 'byebug'

$test = File.split(__FILE__).last.gsub('.rb', '')
$resource = $test.gsub(/^(create|edit|get|put)_/, '')

module Tests
  module GetLiquidLoan
    extend self

    def run(test_run, username, password, liquid_loan_id)
      runner = $resource.classify.constantize.new(test_run.logger, HOSTNAME, PORT, username, password)
      test_run.logger.debug "GETting liquid loan with id: '#{liquid_loan_id}'"
      results = runner.send($test, liquid_loan_id)
    end
  end
end

begin
  unless ARGV.length == 3
    puts "Usage: ruby #{__FILE__} username password liquid_loan_id\n"
    exit
  end

  test_run = Test.new($test.gsub('_', '-'), Logger::DEBUG)
  test_run.start

  username = ARGV[0]
  password = ARGV[1]
  liquid_loan_id = ARGV[2]

  test_run.logger.debug "Fetching account with '#{username}' '#{password}'\n\n"

  results = "Tests::#{$test.classify}".constantize.run(test_run, username, password, liquid_loan_id)
  test_run.logger.debug results

  test_run.stop
  test_run.logger.debug('=' * 30)
  test_run.logger.debug "Elapsed Time: #{test_run.elapsed_time} s\n"

rescue => e
  puts e.message
end
