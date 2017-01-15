require_relative 'integration_test'
require_relative '../fixtures/credit_application'

class CreditApplication < IntegrationTest

  def create_credit_application(body)
    fail 'Missing body' unless body
    login

    fail 'Missing auth_token' unless @auth_token
    
    @logger.debug 'Posting Credit Application'
    response = Request::post(
      @logger,
      host,
      CREDIT_APPLICATION_PATH,
      body.to_json,
      Request::headers(@auth_token),
      true)
    response_hash = parse_response(response)
  end

  def get_credit_application(application_id)
    fail 'Missing application_id' unless application_id
    login

    fail 'Missing auth_token' unless @auth_token
    
    @logger.debug 'Fetching Credit Application'
    response = Request::get(
      @logger,
      host,
      "#{CREDIT_APPLICATION_PATH}/#{application_id}",
      Request::headers(@auth_token),
      true)
    response_hash = parse_response(response)
  end

  def index_credit_applications
    login

    fail 'Missing auth_token' unless @auth_token
    
    @logger.debug 'Fetching Credit Applications'
    response = Request::get(
      @logger,
      host,
      "#{CREDIT_APPLICATION_PATH}/index",
      Request::headers(@auth_token),
      true)
    response_hash = parse_response(response)
  end

  def put_credit_application(application_id, body)
    fail 'Missing application_id' unless application_id
    fail 'Missing body' unless body
    login

    fail 'Missing auth_token' unless @auth_token
    
    @logger.debug 'Putting Credit Application'
    response = Request::put(
      @logger,
      host,
      "#{CREDIT_APPLICATION_PATH}/#{application_id}",
      body.to_json,
      Request::headers(@auth_token),
      true)
    response_hash = parse_response(response)
  end

end
