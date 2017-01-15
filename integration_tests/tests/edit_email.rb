require_relative '../objects/account'

module Tests

  module EditEmail

    extend self

    def run(test_run, username, password, new_email_address, fixture_name)
      acct = Account.new(test_run.logger, HOSTNAME, PORT, username, password)
      body = fixture(fixture_name, new_email_address)
      results = acct.update_email(body)

      test_run.logger.debug 'Edit email request successful, must confirm before complete'
      test_run.logger.debug "Email Address: #{acct.email_address}"
      test_run.logger.debug "Unconfirmed Email Address: #{acct.unconfirmed_email_address}"
      test_run.logger.debug 'Links returned:'
      acct.links.each do |link|
        test_run.logger.debug link
      end

    end

    private 

      def fixture(fixture_name, *params)
        fixture_name ? Fixtures::Account.send(fixture_name, *params) : Fixtures::Account::valid_data_email(*params)
      end
  end
end

begin
  unless ARGV.length.between?(3, 4)
    puts "Usage: ruby edit_email.rb username password new_email_address fixture_name\n"
    exit
  end

  test_run = Test.new('edit-email', Logger::DEBUG)
  test_run.start

  username = ARGV[0]
  password = ARGV[1]
  new_email_address = ARGV[2]
  fixture_name = ARGV[3]

  test_run.logger.debug "Editing email with '#{username}' '#{password}' '#{new_email_address}'"
  test_run.logger.debug "Using fixture: #{fixture_name}" if fixture_name

  test_run.logger.debug ''
  results = Tests::EditEmail.run(test_run, username, password, new_email_address, fixture_name)
  
  test_run.stop
  test_run.logger.debug '==============================='
  test_run.logger.debug "Elapsed Time: #{test_run.elapsed_time} s\n"
  
rescue StandardError => e
  puts e

end
