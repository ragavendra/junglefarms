require_relative 'integration_test'
require_relative '../fixtures/funding_info'

class FundingInfo < IntegrationTest

  def add_funding_info(credit_application_id, body)
    fail 'Missing body' unless body
    login
    fail 'Missing auth_token' unless @auth_token

    @logger.debug 'Adding Funding Details'
    response = Request::post(
      @logger,
      host,
      "#{CREDIT_APPLICATION_PATH}/#{credit_application_id}/funding_info",
      body.to_json,
      Request::headers(@auth_token),
      true)
    parse_response(response)
  end

  def get_funding_info(application_id)
    fail 'Missing application_id' unless application_id
    login

    fail 'Missing auth_token' unless @auth_token

    @logger.debug 'Fetching Funding Info'
    response = Request::get(
      @logger,
      host,
      "#{CREDIT_APPLICATION_PATH}/#{application_id}/funding_info",
      Request::headers(@auth_token),
      true)
    response_hash = parse_response(response)
  end

  def put_funding_info(application_id, body)
    fail 'Missing application_id' unless application_id
    fail 'Missing body' unless body
    login

    fail 'Missing auth_token' unless @auth_token

    @logger.debug 'Updating Funding Info'
    response = Request::put(
      @logger,
      host,
      "#{CREDIT_APPLICATION_PATH}/#{application_id}/funding_info",
      body.to_json,
      Request::headers(@auth_token),
      true)
    response_hash = parse_response(response)
  end

end
