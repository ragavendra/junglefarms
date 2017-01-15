#!/usr/bin/env ruby
require_relative '../objects/additional_document'

module Tests
  module GetAdditionalDocument
    extend self

    def run(test_run, username, password, credit_application_id, document_type = 'photo_id')
      acct = AdditionalDocument.new(test_run.logger, HOSTNAME, PORT, username, password)
      test_run.logger.debug "Fetching additional document for application with id: #{credit_application_id}"
      results = acct.get_additional_document(credit_application_id, document_type)
    end

  end
end

begin
  unless ARGV.length.between?(3, 4)
    puts "Usage: ruby get_additional_document.rb username password application_id document_type\n"
    exit
  end

  test_run = Test.new('get-additional-document', Logger::DEBUG)
  test_run.start

  username = ARGV[0]
  password = ARGV[1]
  application_id = ARGV[2]
  document_type = ARGV[3] || 'photo_id'

  test_run.logger.debug "Fetching account with '#{username}' '#{password}'\n\n"

  results = Tests::GetAdditionalDocument.run(test_run, username, password, application_id, document_type)
  test_run.logger.debug results

  test_run.stop
  test_run.logger.debug '==============================='
  test_run.logger.debug "Elapsed Time: #{test_run.elapsed_time} s\n"

rescue => e
  puts e.message
end
