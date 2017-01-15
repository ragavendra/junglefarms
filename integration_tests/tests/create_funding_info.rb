require_relative '../objects/funding_info'

module Tests

  module CreateFundingInfo

    extend self

    def run(test_run, username, password, credit_application_id, fixture_name = nil)
      acct = FundingInfo.new(test_run.logger, HOSTNAME, PORT, username, password)
      body = fixture(fixture_name)
      results = acct.add_funding_info(credit_application_id, body)
    end

    private 

      def fixture(fixture_name)
        fixture_name ? Fixtures::FundingInfo.send(fixture_name) : Fixtures::FundingInfo::valid_data
      end
  end
end

begin
  unless ARGV.length.between?(3, 4)
    puts "Usage: ruby #{__FILE__} username password credit_application_id fixture_name\n"
    exit
  end

  test_run = Test.new('add-funding-info', Logger::DEBUG)

  username = ARGV[0]
  password = ARGV[1]
  credit_application_id = ARGV[2]
  fixture_name = ARGV[3]

  test_run.logger.debug "Fetching account with '#{username}' '#{password}'\n\n"
  test_run.logger.debug "Using fixture: #{fixture_name}" if fixture_name

  test_run.start
  results = Tests::CreateFundingInfo.run(test_run, username, password, credit_application_id, fixture_name)
  test_run.stop

  test_run.logger.debug results

  test_run.logger.debug '==============================='
  test_run.logger.debug "Elapsed Time: #{test_run.elapsed_time} s\n"
  
rescue => e
  puts e.message
end
