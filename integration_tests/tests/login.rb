require_relative '../objects/account'

module Tests

  module Login

    extend self

    def run(test_run, username, password)
      acct = Account.new(test_run.logger, HOSTNAME, PORT, username, password)
      acct.login

      test_run.logger.debug "Member logged in"
      test_run.logger.debug "Auth Token: #{acct.auth_token}"
      test_run.logger.debug "Links returned:"
      acct.links.each do |link|
        test_run.logger.debug link
      end
      acct
    end
  end
end

begin
  unless ARGV.length == 2
    puts "Usage: ruby login.rb username password\n"
    exit
  end

  test_run = Test.new('login', Logger::DEBUG)
  test_run.start

  username = ARGV[0]
  password = ARGV[1]
  test_run.logger.debug "Logging in with '#{username}' '#{password}'"
  test_run.logger.debug ''
  results = Tests::Login.run(test_run, username, password)

  test_run.stop
  test_run.logger.debug '==============================='
  test_run.logger.debug "Elapsed Time: #{test_run.elapsed_time} s\n"
  
rescue StandardError => e
  puts e

end
