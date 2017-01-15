require_relative '../objects/credit_application'

module Tests

  module CreateCreditApplication

    extend self

    def run(test_run, username, password, fixture_name = nil)
      acct = CreditApplication.new(test_run.logger, HOSTNAME, PORT, username, password)
      body = fixture(fixture_name)
      results = acct.create_credit_application(body)
    end

    private 

      def fixture(fixture_name)
        fixture_name ? Fixtures::CreditApplication.send(fixture_name) : Fixtures::CreditApplication::valid_data
      end
  end
end

begin
  unless ARGV.length.between?(2, 3)
    puts "Usage: ruby create_credit_application.rb username password fixture_name\n"
    exit
  end

  test_run = Test.new('create-credit-application', Logger::DEBUG)
  test_run.start

  username = ARGV[0]
  password = ARGV[1]
  fixture_name = ARGV[2]

  test_run.logger.debug "Fetching account with '#{username}' '#{password}'\n\n"
  test_run.logger.debug "Using fixture: #{fixture_name}" if fixture_name

  results = Tests::CreateCreditApplication.run(test_run, username, password, fixture_name)
  test_run.logger.debug results

  test_run.stop
  test_run.logger.debug '==============================='
  test_run.logger.debug "Elapsed Time: #{test_run.elapsed_time} s\n"
  
rescue => e
  puts e.message
end
