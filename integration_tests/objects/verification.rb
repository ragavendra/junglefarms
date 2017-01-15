require_relative 'integration_test'
require_relative '../fixtures/verifications'

class Verification < IntegrationTest

  def create_contact_number(application_id, body)
    fail 'Missing body' unless body
    login

    fail 'Missing auth_token' unless @auth_token
    @logger.debug 'Create Contact Number PIN and send message to Telesign Service'
    response = Request::post(
      @logger,
      host,
      "#{VERIFICATION_PATH}/credit_applications/#{application_id}/contact_number",
      body.to_json,
      Request::headers(@auth_token),
      true)
    response_hash = parse_response(response)
  end

  def get_resource(application_id, resource_name, stub_data = nil)
    fail 'Missing application_id' unless application_id
    login

    fail 'Missing auth_token' unless @auth_token

    @logger.debug "Fetching #{resource_name} Verification Info"
    response = Request::get(
      @logger,
      host,
      "#{VERIFICATION_PATH}/credit_applications/#{application_id}/#{resource_name}",
      Request::headers(@auth_token),
      true)

    response_hash = parse_response(response)
  end

  def put_contact_number(application_id, body)
    fail 'Missing application_id' unless application_id
    fail 'Missing body' unless body
    login

    fail 'Missing auth_token' unless @auth_token
    
    response = Request::put(
      @logger,
      host,
      "#{VERIFICATION_PATH}/credit_applications/#{application_id}/contact_number",
      body.to_json,
      Request::headers(@auth_token),
      true)
    response_hash = parse_response(response)
  end
end
