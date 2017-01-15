#!/usr/bin/env ruby
require_relative '../objects/additional_document'

module Tests
  module CreateAdditionalDocument
    extend self

    def run(test_run, username, password, credit_application_id, document_type = 'photo_id', fixture_name = nil)
      acct = AdditionalDocument.new(test_run.logger, HOSTNAME, PORT, username, password)
      test_run.logger.debug "Creating additional document for application with id: #{credit_application_id}"
      body = fixture(fixture_name)
      results = acct.create_additional_document(credit_application_id, body, document_type)
    end

    private

    def fixture(fixture_name)
      fixture_name ? Fixtures::AdditionalDocument.send(fixture_name) : Fixtures::AdditionalDocument::valid_data
    end

  end
end

begin
  unless ARGV.length.between?(3, 4)
    puts "Usage: ruby create_additional_document.rb username password application_id document_type fixture_name\n"
    exit
  end

  test_run = Test.new('create-additional-document', Logger::DEBUG)
  test_run.start

  username = ARGV[0]
  password = ARGV[1]
  application_id = ARGV[2]
  document_type = ARGV[3] || 'photo_id'
  fixture_name = ARGV[4]

  test_run.logger.debug "Fetching account with '#{username}' '#{password}'\n\n"
  test_run.logger.debug "Using fixture: #{fixture_name}" if fixture_name

  results = Tests::CreateAdditionalDocument.run(test_run, username, password, application_id, document_type, fixture_name)
  test_run.logger.debug results

  test_run.stop
  test_run.logger.debug '==============================='
  test_run.logger.debug "Elapsed Time: #{test_run.elapsed_time} s\n"

rescue => e
  puts e.message
end
