require_relative '../objects/verification'

module Tests

  module GetAdditionalDocumentVerification

    extend self

    def run(test_run, username, password, credit_application_id, doc_type)
      # This needs to be removed after the uploads service is created
      verification = Verification.new(test_run.logger, HOSTNAME, PORT, username, password)
      results = verification.get_resource(credit_application_id, doc_type)
    end
  end
end

begin
  unless ARGV.length == 4
    puts "Usage: ruby get_additional_doc_verification.rb username password credit_application_id doc_type\n"
    exit
  end

  test_run = Test.new('get-additional-doc-verification', Logger::DEBUG)
  test_run.start

  username = ARGV[0]
  password = ARGV[1]
  credit_application_id = ARGV[2]
  doc_type = ARGV[3]

  test_run.logger.debug "Fetching account with '#{username}' '#{password}'\n\n"
  test_run.logger.debug "Using credit application ID: #{credit_application_id} and doc type: #{doc_type}"

  results = Tests::GetAdditionalDocumentVerification.run(test_run, username, password, credit_application_id, doc_type)
  test_run.logger.debug results

  test_run.stop
  test_run.logger.debug '==============================='
  test_run.logger.debug "Elapsed Time: #{test_run.elapsed_time} s\n"
  
rescue => e
  puts e.message
end