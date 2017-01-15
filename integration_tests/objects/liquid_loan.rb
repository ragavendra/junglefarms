require_relative '../setup'

require 'constants'
require 'objects/integration_test'
require 'fixtures/liquid_loan'

class LiquidLoan < IntegrationTest

  def create_liquid_loan(body)
    fail 'Missing body' unless body
    login

    fail 'Missing auth_token' unless @auth_token

    @logger.debug 'POSTing Liquid Loan'
    response = Request::post(
      @logger,
      host,
      LIQUID_LOAN_PATH,
      body.to_json,
      Request::headers(@auth_token),
      true)
    response_hash = parse_response(response)
  end

  def get_liquid_loan(liquid_loan_id)
    fail 'Missing liquid_loan_id' unless liquid_loan_id
    login

    fail 'Missing auth_token' unless @auth_token

    @logger.debug 'GETting Liquid Loan'
    response = Request::get(
      @logger,
      host,
      "#{LIQUID_LOAN_PATH}/#{liquid_loan_id}",
      Request::headers(@auth_token),
      true)
    response_hash = parse_response(response)
  end

  def put_liquid_loan(liquid_loan_id, body)
    fail 'Missing liquid_loan_id' unless liquid_loan_id
    fail 'Missing body' unless body
    login

    fail 'Missing auth_token' unless @auth_token

    @logger.debug 'PUTting Liquid Loan'
    response = Request::put(
      @logger,
      host,
      "#{LIQUID_LOAN_PATH}/#{liquid_loan_id}",
      body.to_json,
      Request::headers(@auth_token),
      true)
    response_hash = parse_response(response)
  end


end
