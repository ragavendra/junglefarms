#!/usr/bin/env ruby
require_relative '../objects/contact_number'

module Tests
  module EditContactNumber
    extend self

    def run(test_run, username, password, credit_application_id, fixture_name = nil)
      acct = ContactNumber.new(test_run.logger, HOSTNAME, PORT, username, password)
      test_run.logger.debug "Updating contact number for application with id: #{credit_application_id}"
      body = fixture(fixture_name)
      results = acct.edit_contact_number(credit_application_id, body)
    end

    private

    def fixture(fixture_name)
      fixture_name ? Fixtures::ContactNumber.send(fixture_name) : Fixtures::ContactNumber::valid_data
    end

  end
end

begin
  unless ARGV.length.between?(3, 4)
    puts "Usage: ruby edit_contact_number.rb username password application_id fixture_name\n"
    exit
  end

  test_run = Test.new('edit-contact-number', Logger::DEBUG)
  test_run.start

  username = ARGV[0]
  password = ARGV[1]
  application_id = ARGV[2]
  fixture_name = ARGV[3]

  test_run.logger.debug "Fetching account with '#{username}' '#{password}'\n\n"
  test_run.logger.debug "Using fixture: #{fixture_name}" if fixture_name

  results = Tests::EditContactNumber.run(test_run, username, password, application_id, fixture_name)
  test_run.logger.debug results

  test_run.stop
  test_run.logger.debug '==============================='
  test_run.logger.debug "Elapsed Time: #{test_run.elapsed_time} s\n"

rescue => e
  puts e.message
end
