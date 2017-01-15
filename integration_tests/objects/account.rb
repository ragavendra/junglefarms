require_relative 'integration_test'
require_relative '../fixtures/account'

class Account < IntegrationTest

  def signup(opt_in_email = true, body_overrides = {})
    @opt_in_email = opt_in_email

    body = {
      email_address: @username,
      password: @password,
      opt_in_email: @opt_in_email
    }.merge(body_overrides)

    response = Request::post(
      @logger,
      host,
      ACCOUNTS_PATH,
      body.to_json,
      Request::headers,
      true)
    response_hash = parse_response(response)

    @signed_up = true
    @links = response_hash[:links]
    @uuid = response_hash[:uuid]
  end

  def update_email(body)
    login

    fail 'Missing auth_token' unless @auth_token
    
    @logger.debug 'Updating email'
    response = Request::put(
      @logger,
      host,
      ACCOUNTS_PATH,
      body.to_json,
      Request::headers(@auth_token),
      true)
    response_hash = parse_response(response)

    @links = response_hash[:links]
    @email_address = response_hash[:email_address]
    @unconfirmed_email_address = response_hash[:unconfirmed_email]
    response_hash
  end

  def fetch_account
    login

    fail 'Missing auth_token' unless @auth_token

    @logger.debug 'Fetching account details'
    response = Request::get(
      @logger,
      host,
      ACCOUNTS_PATH,
      Request::headers(@auth_token),
      true)

    response_hash = parse_response(response)
    @links = response_hash[:links]
    @uuid = response_hash[:uuid]
    response_hash
  end

end
