require 'httmultiparty'
require 'byebug'
require 'json'

# do not verify ssl
HTTMultiParty::Basement.default_options.update(verify: false)

POLL_ATTEMPTS = 60

#
module Request
  extend self

  def get(logger, hostname, path, headers, follow_up = false)
    uri = "#{hostname}#{path}"
    logger.debug "GET to #{uri}"
    response = HTTMultiParty.get(uri, headers: headers)
    display_response(logger, response)

    if follow_up
      fail 'GET response code is not 202, not following' unless response.code == 202

      reponse_hash = JSON.parse(response.body, symbolize_names: true) if response.body
      fail 'GET response has no polling url' unless reponse_hash[:polling_url]

      response = poll(logger, hostname, reponse_hash[:polling_url], headers)
    end
    response
  end

  def post(logger, hostname, path, body, headers, follow_up = false)
    uri = "#{hostname}#{path}"

    logger.debug "POST to #{uri}"
    response = HTTMultiParty.post(
      uri,
      body: body,
      headers: headers
    )

    display_response(logger, response)

    if follow_up
      logger.debug "POST Response code: #{response.code}"

      fail 'POST response code is not 202, not following' unless response.code == 202

      reponse_hash = JSON.parse(response.body, symbolize_names: true) if response.body
      fail 'POST response has no polling url' unless reponse_hash[:polling_url]

      response = poll(logger, hostname, reponse_hash[:polling_url], headers)
    end
    response
  end

  def put(logger, hostname, path, body, headers, follow_up = false)
    uri = "#{hostname}#{path}"

    logger.debug "PUT to #{uri}"
    response = HTTMultiParty.put(
      uri,
      body: body,
      headers: headers
    )

    display_response(logger, response)

    if follow_up
      fail 'PUT response code is not 202, not following' unless response.code == 202

      reponse_hash = JSON.parse(response.body, symbolize_names: true) if response.body
      fail 'PUT response has no polling url' unless reponse_hash[:polling_url]

      response = poll(logger, hostname, reponse_hash[:polling_url], headers)
    end
    response
  end

  def delete(logger, hostname, path, headers, follow_up = false)
    uri = "#{hostname}#{path}"

    logger.debug "DELETE to #{uri}"
    response = HTTMultiParty.delete(
      uri,
      body: {},
      headers: headers
    )

    display_response(logger, response)

    if follow_up
      fail 'DELETE response code is not 202, not following' unless response.code == 202

      reponse_hash = JSON.parse(response.body, symbolize_names: true) if response.body
      fail 'DELETE response has no polling url' unless reponse_hash[:polling_url]

      response = poll(logger, hostname, reponse_hash[:polling_url], headers)
    end
    response
  end

  def poll(logger, hostname, path, headers)
    POLL_ATTEMPTS.times do |itr|
      logger.debug "poll attempt #{itr+1}..."
      sleep 1
      response = get(logger, hostname, path, headers)
      return response if response.code != 202
    end
    logger.debug '--------------------------------'
    logger.debug "Timed out polling url: #{hostname}#{path}"
    logger.debug '--------------------------------'
    exit
  end

  def display_response(logger, response)
    logger.debug '--------------------------------'
    logger.debug "response code: #{response.code}"
    logger.debug "response body: #{response.body}"
    logger.debug '--------------------------------'
    logger.debug ''
  end

  def headers(auth_token = nil)
    headers = { "Content-Type" => "application/json", "Accept" => "application/vnd.mogo.v2" }
    # headers['Cookie'] = "auth_token=\"#{auth_token}\"" if auth_token
    headers['X-Auth-Token'] = auth_token if auth_token
    headers
  end

end
