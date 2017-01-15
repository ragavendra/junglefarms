require_relative '../objects/verification'

module Tests
  module GetContactNumberVerification

    extend self

    def run(test_run, username, password, credit_application_id)
      verification = Verification.new(test_run.logger, HOSTNAME, PORT, username, password)
      results = verification.get_resource(credit_application_id, 'contact_number')
    end
  end
end

begin
  unless ARGV.length == 3
    puts "Usage: ruby get_contact_number_verification.rb username password credit_application_id\n"
    exit
  end

  test_run = Test.new('get-contact-number-verification', Logger::DEBUG)
  test_run.start

  username = ARGV[0]
  password = ARGV[1]
  credit_application_id = ARGV[2]

  test_run.logger.debug "Fetching account with '#{username}' '#{password}'\n\n"
  test_run.logger.debug "Using credit application ID: #{credit_application_id}"

  results = Tests::GetContactNumberVerification.run(test_run, username, password, credit_application_id)
  test_run.logger.debug results

  test_run.stop
  test_run.logger.debug '==============================='
  test_run.logger.debug "Elapsed Time: #{test_run.elapsed_time} s\n"
  
rescue => e
  puts e.message
end
