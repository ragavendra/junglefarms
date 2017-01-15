require_relative '../objects/credit_application'

module Tests

  module PutCreditApplication

    extend self

    def run(test_run, username, password, application_id, transaction_id)
      acct = CreditApplication.new(test_run.logger, HOSTNAME, PORT, username, password)

      test_run.logger.debug ' => Testing with valid post data'
      answers_payload = sample_answers_payload(transaction_id: transaction_id)

      results = acct.put_credit_application(application_id, answers_payload)
    end
  end
end

def sample_answers_payload(overrides={})
  {
    transaction_id: '1122334455',
    kyc_answers: [
      { question_id: 1, answer_id: 1 },
      { question_id: 2, answer_id: 5 },
      { question_id: 3, answer_id: 5 }
    ]
  }.merge(overrides)
end

begin
  unless ARGV.length == 4
    puts "Usage: ruby create_credit_application.rb username password application_id transaction_id\n"
    exit
  end

  test_run = Test.new('put-credit-application', Logger::DEBUG)
  test_run.start

  username = ARGV[0]
  password = ARGV[1]
  application_id = ARGV[2]
  transaction_id = ARGV[3]
  test_run.logger.debug "Fetching account with '#{username}' '#{password}'\n\n"
  results = Tests::PutCreditApplication.run(test_run, username, password, application_id, transaction_id)
  test_run.logger.debug results

  test_run.stop
  test_run.logger.debug '==============================='
  test_run.logger.debug "Elapsed Time: #{test_run.elapsed_time} s\n"
  
rescue => e
  puts e.message
end
