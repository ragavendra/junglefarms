require_relative '../objects/employment_info'

module Tests

  module GetEmploymentInfo

    extend self

    def run(test_run, username, password, credit_application_id)
      acct = EmploymentInfo.new(test_run.logger, HOSTNAME, PORT, username, password)
      test_run.logger.debug "Fetching employment info for application with id: #{credit_application_id}"
      results = acct.get_employment_info(credit_application_id)
    end
  end
end

begin
  unless ARGV.length == 3
    puts "Usage: ruby get_employment_info.rb username password credit_application_id\n"
    exit
  end

  test_run = Test.new('get-employment-details', Logger::DEBUG)
  test_run.start

  username = ARGV[0]
  password = ARGV[1]
  credit_application_id = ARGV[2]

  test_run.logger.debug "Fetching account with '#{username}' '#{password}'\n\n"
  test_run.logger.debug "Using credit application ID: #{credit_application_id}"
  
  results = Tests::GetEmploymentInfo.run(test_run, username, password, credit_application_id)
  test_run.logger.debug results

  test_run.stop
  test_run.logger.debug '==============================='
  test_run.logger.debug "Elapsed Time: #{test_run.elapsed_time} s\n"
  
rescue => e
  puts e.message
end
