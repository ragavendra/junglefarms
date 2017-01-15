require_relative '../objects/account'

module Tests

  module Signup

    extend self

    def run(test_run, fixture_name)

      body = fixture(fixture_name)

      acct = Account.new(test_run.logger, HOSTNAME, PORT, *body)
      opt_in_email = true
      acct.signup(opt_in_email)
      
      test_run.logger.debug "Member #{acct.uuid} signed up" if acct.signed_up?
      test_run.logger.debug "Username: #{acct.username}"
      test_run.logger.debug "Password: #{acct.password}"
      test_run.logger.debug 'Links returned:'
      acct.links.each do |link|
        test_run.logger.debug link
      end

      acct
    end

    private

      def fixture(fixture_name, *params)
        fixture_name ? Fixtures::Account.send(fixture_name, *params) : Fixtures::Account::valid_data_sign_up(*params)
      end

  end
end

begin
  unless ARGV.length.between?(0, 1)
    puts "Usage: ruby signup.rb fixture_name\n"
    exit
  end

  test_run = Test.new('signup', Logger::DEBUG)
  test_run.start

  fixture_name = ARGV[0]
  test_run.logger.debug "Using fixture: #{fixture_name}" if fixture_name
  test_run.logger.debug ''
  Tests::Signup.run(test_run, fixture_name)

  test_run.stop
  test_run.logger.debug '==============================='
  test_run.logger.debug "Elapsed Time: #{test_run.elapsed_time} s\n"

rescue StandardError => e
  puts e

end

