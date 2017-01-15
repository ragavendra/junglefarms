require_relative 'integration_test'
require_relative '../fixtures/additional_document'

class AdditionalDocument < IntegrationTest

  def get_additional_document(application_id, document_type)
    fail 'Missing application_id' unless application_id
    login
    fail 'Missing auth_token' unless @auth_token

    @logger.debug 'Fetching Additional document'
    response = Request::get(
      @logger,
      host,
      "#{CREDIT_APPLICATION_PATH}/#{application_id}/additional_doc/#{document_type}",
      Request::headers(@auth_token),
      true)
    response_hash = parse_response(response)
  end

  def create_additional_document(application_id, body, document_type)
    fail 'Missing application_id' unless application_id
    login
    fail 'Missing auth_token' unless @auth_token

    @logger.debug 'Uploading Additional document'

    response = Request::post(
      @logger,
      host,
      "#{CREDIT_APPLICATION_PATH}/#{application_id}/additional_doc/#{document_type}",
      body,
      Request::headers(@auth_token),
      true)
    response_hash = parse_response(response)
  end

  def delete_additional_document(application_id, document_type)
    fail 'Missing application_id' unless application_id
    login
    fail 'Missing auth_token' unless @auth_token
    @logger.debug 'Deleting Additional document'
    response = Request::delete(
      @logger,
      host,
      "#{CREDIT_APPLICATION_PATH}/#{application_id}/additional_doc/#{document_type}",
      Request::headers(@auth_token),
      true)
    response_hash = parse_response(response)
  end

end
