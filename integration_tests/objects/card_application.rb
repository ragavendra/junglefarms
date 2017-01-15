require_relative 'integration_test'
require_relative '../fixtures/card_application'

class CardApplication < IntegrationTest

  def create_card_application(body)
    fail 'Missing body' unless body
    login

    fail 'Missing auth_token' unless @auth_token
    
    @logger.debug 'Posting Card Application'
    response = Request::post(
      @logger,
      host,
      CARD_APPLICATION_PATH,
      body.to_json,
      Request::headers(@auth_token),
      true)
    response_hash = parse_response(response)
  end

  def get_card_application(application_id)
    fail 'Missing application_id' unless application_id
    login

    fail 'Missing auth_token' unless @auth_token
    
    @logger.debug 'Fetching Card Application'
    response = Request::get(
      @logger,
      host,
      "#{CARD_APPLICATION_PATH}/#{application_id}",
      Request::headers(@auth_token),
      true)
    response_hash = parse_response(response)
  end

end