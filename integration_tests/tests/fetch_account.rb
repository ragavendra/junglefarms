require_relative '../objects/account'

module Tests

  module FetchAccount

    extend self

    def run(test_run, username, password)
      
      acct = Account.new(test_run.logger, HOSTNAME, PORT, username, password)
      results = acct.fetch_account

      test_run.logger.debug "Raw Account response: #{results}\n\n"

      test_run.logger.debug "Member UUID: #{results[:uuid]}"
      test_run.logger.debug "Email Address/Username: #{results[:email_address]}"
      test_run.logger.debug 'Links returned:'
      results[:links].each do |link|
        test_run.logger.debug link
      end
      ''
    end
  end
end

begin
  unless ARGV.length == 2
    puts "Usage: ruby fetch_account.rb username password\n"
    exit
  end

  test_run = Test.new('fetch-account', Logger::DEBUG)
  test_run.start

  username = ARGV[0]
  password = ARGV[1]
  test_run.logger.debug "Fetching account with '#{username}' '#{password}'"
  test_run.logger.debug ''
  results = Tests::FetchAccount.run(test_run, username, password)
  test_run.logger.debug results

  test_run.stop
  test_run.logger.debug '==============================='
  test_run.logger.debug "Elapsed Time: #{test_run.elapsed_time} s\n"
  
rescue StandardError => e
  puts e

end
