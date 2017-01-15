require_relative '../objects/credit_application'

module Tests

  module IndexCreditApplications
    extend self
    def run(test_run, username, password)
      test_runner = CreditApplication.new(test_run.logger, HOSTNAME, PORT, username, password)
      test_run.logger.debug "Fetching applications for member"
      results = test_runner.index_credit_applications
    end
  end
end

begin
  unless ARGV.length == 2
    puts "Usage: ruby index_credit_applications.rb username password\n"
    exit
  end

  test_run = Test.new('get-index-credit-applications', Logger::DEBUG)
  test_run.start

  username = ARGV[0]
  password = ARGV[1]
  test_run.logger.debug "Fetching account with '#{username}' '#{password}'\n\n"
  results = Tests::IndexCreditApplications.run(test_run, username, password)
  test_run.logger.debug results

  test_run.stop
  test_run.logger.debug '==============================='
  test_run.logger.debug "Elapsed Time: #{test_run.elapsed_time} s\n"
  
rescue => e
  puts e.message
end
