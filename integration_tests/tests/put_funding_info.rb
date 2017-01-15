require_relative '../objects/funding_info'

module Tests

  module PutFundingInfo

    extend self

    def run(test_run, username, password, credit_application_id, fixture_name = nil)
      acct = FundingInfo.new(test_run.logger, HOSTNAME, PORT, username, password)
      test_run.logger.debug "Updating funding info for application with id: #{credit_application_id}"
      update_params = fixture(fixture_name)
      results = acct.put_funding_info(credit_application_id, update_params)
    end

    private

    def fixture(fixture_name)
      fixture_name ? Fixtures::FundingInfo.send(fixture_name) : Fixtures::FundingInfo::valid_data
    end

  end
end

begin
  unless ARGV.length == 3 || ARGV.length == 4
    puts "Usage: ruby put_funding_info.rb username password credit_application_id\n"
    exit
  end

  test_run = Test.new('put-funding-info', Logger::DEBUG)
  test_run.start

  username = ARGV[0]
  password = ARGV[1]
  credit_application_id = ARGV[2]
  fixture_name = ARGV[3]

  test_run.logger.debug "Fetching account with '#{username}' '#{password}'\n\n"
  test_run.logger.debug "Using credit application ID: #{credit_application_id}"

  results = Tests::PutFundingInfo.run(test_run, username, password, credit_application_id, fixture_name)
  test_run.logger.debug results

  test_run.stop
  test_run.logger.debug '==============================='
  test_run.logger.debug "Elapsed Time: #{test_run.elapsed_time} s\n"

rescue => e
  puts e.message
end
