#!/usr/bin/env ruby
require_relative '../objects/contact_number'

module Tests
  module GetContactNumber
    extend self

    def run(test_run, username, password, credit_application_id)
      acct = ContactNumber.new(test_run.logger, HOSTNAME, PORT, username, password)
      test_run.logger.debug "Fetching contact number for application with id: #{credit_application_id}"
      results = acct.get_contact_number(credit_application_id)
    end

  end
end

begin
  unless ARGV.length == 3
    puts "Usage: ruby get_contact_number.rb username password application_id\n"
    exit
  end

  test_run = Test.new('get-contact-number', Logger::DEBUG)
  test_run.start

  username = ARGV[0]
  password = ARGV[1]
  application_id = ARGV[2]
  test_run.logger.debug "Fetching account with '#{username}' '#{password}'\n\n"
  results = Tests::GetContactNumber.run(test_run, username, password, application_id)
  test_run.logger.debug results

  test_run.stop
  test_run.logger.debug '==============================='
  test_run.logger.debug "Elapsed Time: #{test_run.elapsed_time} s\n"

rescue => e
  puts e.message
end
