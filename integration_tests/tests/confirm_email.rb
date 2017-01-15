require_relative '../objects/account'

module Tests

  module ConfirmEmail 

    extend self

    def run(test_run, confirmation_token, fixture_name = nil)
      
      body = fixture(fixture_name, confirmation_token)

      response = Request::post(
        test_run.logger,
        test_run.url,
        CONFIRM_EMAIL_PATH,
        body.to_json,
        Request::headers,
        true)

      if response.code == 200
        return 'No response body' unless response.body

        response_hash = JSON.parse(response.body, symbolize_names: true) if response.body
        return "Error: #{response_hash[:error]}" if response_hash[:error]

        test_run.logger.debug "Member #{response_hash[:uuid]} confirmed"
        test_run.logger.debug 'Links returned:'
        response_hash[:links].each do |link|
          test_run.logger.debug link
        end
        ''
      end
    end

    private

      def fixture(fixture_name, *params)
        fixture_name ? Fixtures::Account.send(fixture_name, *params) : Fixtures::Account::valid_data_activation(*params)
      end

  end
end

begin
  unless ARGV.length.between?(1, 2)
    puts "Usage: ruby confirm_email.rb confirmation_token fixture_name\n"
    puts " 'confirmation_token' is the confirmation token from the change password email\n"
    puts " you can get that by tailing the mailer service log, or the member_service log\n\n"
    exit
  end

  test_run = Test.new('confirm_email', Logger::DEBUG)
  test_run.start

  confirmation_token = ARGV[0]
  fixture_name = ARGV[1]
  test_run.logger.debug "Confirming with '#{confirmation_token}'"
  test_run.logger.debug "Using fixture: #{fixture_name}" if fixture_name
  test_run.logger.debug ''
  results = Tests::ConfirmEmail.run(test_run, confirmation_token, fixture_name)
  test_run.logger.debug results

  test_run.stop
  test_run.logger.debug '==============================='
  test_run.logger.debug "Elapsed Time: #{test_run.elapsed_time} s\n"

rescue StandardError => e
  puts e

end
