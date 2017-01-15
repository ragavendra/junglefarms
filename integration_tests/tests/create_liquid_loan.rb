require 'active_support/core_ext/string/inflections'

require_relative '../setup'

require 'fixtures/liquid_loan'
require 'objects/test'
require 'objects/liquid_loan'
require 'byebug'

$test = File.split(__FILE__).last.gsub('.rb', '')
$resource = $test.gsub(/^(create|edit|get|put)_/, '')

module Tests
  module CreateLiquidLoan
    extend self

    def run(test_run, username, password, credit_application_id, fixture_name = nil)
      @credit_application_id = credit_application_id.to_i
      runner = $resource.classify.constantize.new(test_run.logger, HOSTNAME, PORT, username, password)
      body = fixture(fixture_name)
      results = runner.send($test, body)
    end

    private

      def fixture(fixture_name)
        klass = "Fixtures::#{$resource.classify}".constantize
        fixture_name ? klass.send(fixture_name) : klass.send(:valid_data, credit_application_id: @credit_application_id)
      end
  end
end

begin
  unless ARGV.length.between?(2, 3)
    puts "Usage: ruby #{__FILE__} username password credit_application_id fixture_name\n"
    exit
  end

  test_run = Test.new($test.gsub('_', '-'), Logger::DEBUG)
  test_run.start

  username = ARGV[0]
  password = ARGV[1]
  credit_application_id = ARGV[2]
  fixture_name = ARGV[3]

  test_run.logger.debug "Fetching account with '#{username}' '#{password}'\n\n"
  test_run.logger.debug "Using fixture: #{fixture_name}" if fixture_name

  results = "Tests::#{$test.classify}".constantize.run(test_run, username, password, credit_application_id, fixture_name)
  test_run.logger.debug results

  test_run.stop
  test_run.logger.debug('=' * 30)
  test_run.logger.debug "Elapsed Time: #{test_run.elapsed_time} s\n"

rescue => e
  puts e.message
end
