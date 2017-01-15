require_relative '../objects/account'

module Tests

  module ResetPassword

    extend self

    def run(test_run, new_password, reset_password_token, fixture_name = nil)
      body = fixture(fixture_name, new_password, reset_password_token)
      
      response = Request::post(
        test_run.logger,
        test_run.url,
        RESET_PASSWORD_PATH,
        body.to_json,
        Request::headers,
        true
      )

      if response.code == 200
        return 'No response body' unless response.body

        response_hash = JSON.parse(response.body, symbolize_names: true) if response.body
        return "Error: #{response_hash[:error]}" if response_hash[:error]

        test_run.logger.debug 'Reset Password request sent'
        test_run.logger.debug 'Links returned:'
        response_hash[:links].each do |link|
          test_run.logger.debug link
        end
        ''
      end
    end

    private
      def fixture(fixture_name, *params)
        fixture_name ? Fixtures::Account.send(fixture_name, *params) : Fixtures::Account::valid_data_reset_password(*params)
      end
  end
end

begin
  unless ARGV.length.between?(2, 3)
    puts "Usage: ruby reset_password.rb new_password reset_password_token fixture_name\n"
    exit
  end

  test_run = Test.new('reset-password', Logger::DEBUG)
  test_run.start

  new_password = ARGV[0]
  reset_password_token = ARGV[1]
  fixture_name = ARGV[2]
  test_run.logger.debug "Sending request for Reset Password with '#{new_password}' '#{reset_password_token}'"
  test_run.logger.debug "Using fixture: #{fixture_name}" if fixture_name
  test_run.logger.debug ''
  results = Tests::ResetPassword.run(test_run, new_password, reset_password_token, fixture_name)
  test_run.logger.debug results

  test_run.stop
  test_run.logger.debug '==============================='
  test_run.logger.debug "Elapsed Time: #{test_run.elapsed_time} s\n"
  
rescue StandardError => e
  puts e

end
