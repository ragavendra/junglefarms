require_relative '../objects/verification'

module Tests

  module CreateContactNumberVerification

    extend self

    def run(test_run, username, password, credit_application_id, fixture_name = nil)
      verification = Verification.new(test_run.logger, HOSTNAME, PORT, username, password)
      body = fixture(fixture_name, credit_application_id)
      results = verification.create_contact_number(credit_application_id, body)
    end

    private 

      def fixture(fixture_name, credit_application_id)
        fixture_name ? Fixtures::Verifications.send(fixture_name, credit_application_id) : Fixtures::Verifications::ca_contact_number_valid_data(credit_application_id)
      end
  end
end

begin
  unless ARGV.length.between?(3, 4)
    puts "Usage: ruby create_contact_number_verification.rb username password credit_application_id fixture_name\n"
    exit
  end

  test_run = Test.new('create-contact-number-verification', Logger::DEBUG)
  test_run.start

  username = ARGV[0]
  password = ARGV[1]
  credit_application_id = ARGV[2]
  fixture_name = ARGV[3]

  test_run.logger.debug "Fetching account with '#{username}' '#{password}'\n\n"
  test_run.logger.debug "Using credit application ID: #{credit_application_id}"
  test_run.logger.debug "Using fixture: #{fixture_name}" if fixture_name

  results = Tests::CreateContactNumberVerification.run(test_run, username, password, credit_application_id, fixture_name)
  test_run.logger.debug results

  test_run.stop
  test_run.logger.debug '==============================='
  test_run.logger.debug "Elapsed Time: #{test_run.elapsed_time} s\n"
  
rescue => e
  puts e.message
end
