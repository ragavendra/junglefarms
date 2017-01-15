require_relative 'integration_test'
require_relative '../fixtures/employment_info'

class EmploymentInfo < IntegrationTest

  def create_employment_info(application_id, body)
    fail 'Missing body' unless body
    login

    fail 'Missing auth_token' unless @auth_token
    
    @logger.debug 'Adding Employment Details Credit Application'
    response = Request::post(
      @logger,
      host,
      "#{CREDIT_APPLICATION_PATH}/#{application_id}/employment_info",
      body.to_json,
      Request::headers(@auth_token),
      true)
    response_hash = parse_response(response)
  end

  def get_employment_info(application_id)
    fail 'Missing application_id' unless application_id
    login

    fail 'Missing auth_token' unless @auth_token
    
    @logger.debug 'Fetching Employment Info'
    response = Request::get(
      @logger,
      host,
      "#{CREDIT_APPLICATION_PATH}/#{application_id}/employment_info",
      Request::headers(@auth_token),
      true)
    response_hash = parse_response(response)
  end

  def put_employment_info(application_id, body)
    fail 'Missing application_id' unless application_id
    fail 'Missing body' unless body
    login

    fail 'Missing auth_token' unless @auth_token
    
    response = Request::put(
      @logger,
      host,
      "#{CREDIT_APPLICATION_PATH}/#{application_id}/employment_info",
      body.to_json,
      Request::headers(@auth_token),
      true)
    response_hash = parse_response(response)
  end
  
end
