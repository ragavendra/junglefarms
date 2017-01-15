require_relative '../objects/credit_application'

module Tests

  module GetCreditApplication

    extend self

    def run(test_run, username, password, application_id)
      acct = CreditApplication.new(test_run.logger, HOSTNAME, PORT, username, password)

      test_run.logger.debug "Fetching application id: #{application_id}"
      results = acct.get_credit_application(application_id)
    end
  end
end

begin
  unless ARGV.length == 3
    puts "Usage: ruby create_credit_application.rb username password application_id\n"
    exit
  end

  test_run = Test.new('get-credit-application', Logger::DEBUG)
  test_run.start

  username = ARGV[0]
  password = ARGV[1]
  application_id = ARGV[2]
  test_run.logger.debug "Fetching account with '#{username}' '#{password}'\n\n"
  results = Tests::GetCreditApplication.run(test_run, username, password, application_id)
  test_run.logger.debug results

  test_run.stop
  test_run.logger.debug '==============================='
  test_run.logger.debug "Elapsed Time: #{test_run.elapsed_time} s\n"
  
rescue => e
  puts e.message
end
