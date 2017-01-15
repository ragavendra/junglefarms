require_relative '../lib/request'
require_relative '../objects/test'
require_relative '../constants'
require 'sequel'

class IntegrationTest

  attr_accessor :username
  attr_accessor :password
  attr_accessor :opt_in_email
  attr_accessor :signed_up
  attr_accessor :hostname
  attr_accessor :auth_token
  attr_accessor :links
  attr_accessor :uuid
  attr_accessor :unconfirmed_email_address
  attr_accessor :email_address

  def initialize(logger, hostname, port, username, password)
    @username = username
    @password = password
    @hostname = hostname
    @port = port
    @logger = logger
    @db = set_up_db
  end

  def parse_response(response)
    if response.code == 200
      fail 'No response body' unless response.body

      response_hash = JSON.parse(response.body, symbolize_names: true) if response.body

      @signed_up = false if response_hash[:error]
      fail "Error: #{response_hash[:error]}" if response_hash[:error]
      response_hash
    end
  end

  def login
    body = {
      email_address: @username,
      password: @password
    }

    response = Request::post(
      @logger,
      host,
      SESSIONS_PATH,
      body.to_json,
      Request::headers,
      true)

    response_hash = parse_response(response)

    @auth_token = response_hash[:auth_token]
    @links = response_hash[:links]
    @uuid = response_hash[:uuid]
  end

  def signed_up?
    @signed_up
  end

  def set_up_db
    # DB configuration
    database = Sequel.connect("mysql2://#{@hostname}:3306/soa_db?encoding=utf8&pool=5&username=root&password")
    # raises Sequel::DatabaseConnectionError if it cannot establish a connection with MySQL
    return database
  end

  private

    def host
      "#{SCHEME}://#{@hostname}:#{@port}"
    end
end
