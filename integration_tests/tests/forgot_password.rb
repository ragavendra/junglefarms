require_relative '../objects/account'

module Tests

  module ForgotPassword

    extend self

    def run(test_run, email_address, fixture_name = nil)

      body = fixture(fixture_name, email_address)

      response = Request::post(
        test_run.logger,
        test_run.url,
        FORGOT_PASSWORD_PATH,
        body.to_json,
        Request::headers,
        true)

      if response.code == 200
        return 'No response body' unless response.body

        response_hash = JSON.parse(response.body, symbolize_names: true) if response.body
        return "Error: #{response_hash[:error]}" if response_hash[:error]

        test_run.logger.debug 'Forgot password request sent'
        test_run.logger.debug "Reset Password Token: #{response_hash[:reset_password_token]}"
        test_run.logger.debug 'Links returned:'
        response_hash[:links].each do |link|
          test_run.logger.debug link
        end
        ''
      end
    end

    private

      def fixture(fixture_name, *params)
        fixture_name ? Fixtures::Account.send(fixture_name, *params) : Fixtures::Account::valid_data_email(*params)
      end
  end
end

begin

  unless ARGV.length.between?(1, 2)
    puts "Usage: ruby forgot_password.rb email_address fixture_name\n"
    exit
  end

  test_run = Test.new('forgot-password', Logger::DEBUG)
  test_run.start

  email_address = ARGV[0]
  fixture_name = ARGV[1]
  test_run.logger.debug "Sending request for Forgot Password with '#{email_address}'"
  test_run.logger.debug "Using fixture: #{fixture_name}" if fixture_name
  test_run.logger.debug ''
  results = Tests::ForgotPassword.run(test_run, email_address, fixture_name)
  test_run.logger.debug results

  test_run.stop
  test_run.logger.debug '==============================='
  test_run.logger.debug "Elapsed Time: #{test_run.elapsed_time} s\n"
  
rescue StandardError => e
  puts e

end
