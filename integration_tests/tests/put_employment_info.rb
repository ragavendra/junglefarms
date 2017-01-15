require_relative '../objects/employment_info'

module Tests

  module PutEmploymentInfo

    extend self

    def run(test_run, username, password, credit_application_id, fixture_name = nil)
      acct = EmploymentInfo.new(test_run.logger, HOSTNAME, PORT, username, password)
      body = fixture(fixture_name)
      results = acct.put_employment_info(credit_application_id, body)
    end

    private 

      def fixture(fixture_name)
        fixture_name ? Fixtures::EmploymentInfo.send(fixture_name) : Fixtures::EmploymentInfo::put_valid_data
      end
  end
end

begin
  unless ARGV.length.between?(3, 4)
    puts "Usage: ruby put_employment_info.rb username password credit_application_id fixture_name\n"
    exit
  end

  test_run = Test.new('put-employment-info', Logger::DEBUG)
  test_run.start

  username = ARGV[0]
  password = ARGV[1]
  credit_application_id = ARGV[2]
  fixture_name = ARGV[3]

  test_run.logger.debug "Fetching account with '#{username}' '#{password}'"
  test_run.logger.debug "Using credit application ID: #{credit_application_id}"
  test_run.logger.debug "Using fixture: #{fixture_name}" if fixture_name
  results = Tests::PutEmploymentInfo.run(test_run, username, password, credit_application_id, fixture_name)
  test_run.logger.debug results

  test_run.stop
  test_run.logger.debug '==============================='
  test_run.logger.debug "Elapsed Time: #{test_run.elapsed_time} s\n"
  
rescue => e
  puts e.message
end
