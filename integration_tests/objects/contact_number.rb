require_relative 'integration_test'
require_relative '../fixtures/contact_number'

class ContactNumber < IntegrationTest

  def get_contact_number(application_id)
    fail 'Missing application_id' unless application_id
    login
    fail 'Missing auth_token' unless @auth_token

    @logger.debug 'Fetching Contact Number'
    response = Request::get(
      @logger,
      host,
      "#{CREDIT_APPLICATION_PATH}/#{application_id}/contact_number",
      Request::headers(@auth_token),
      true)
    response_hash = parse_response(response)
  end

  def create_contact_number(application_id, body)
    fail 'Missing application_id' unless application_id
    fail 'Missing body' unless body
    login
    fail 'Missing auth_token' unless @auth_token

    @logger.debug 'Creating contact information for credit application'
    response = Request::post(
      @logger,
      host,
      "#{CREDIT_APPLICATION_PATH}/#{application_id}/contact_number",
      body.to_json,
      Request::headers(@auth_token),
      true)
    response_hash = parse_response(response)
  end

  def edit_contact_number(application_id, body)
    fail 'Missing application_id' unless application_id
    fail 'Missing body' unless body
    login
    fail 'Missing auth_token' unless @auth_token

    @logger.debug 'Updating contact information for credit application'
    response = Request::put(
      @logger,
      host,
      "#{CREDIT_APPLICATION_PATH}/#{application_id}/contact_number",
      body.to_json,
      Request::headers(@auth_token),
      true)
    response_hash = parse_response(response)
  end

end
