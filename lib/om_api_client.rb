module OM
  module Api
    require "om_api_client/version"
  end
end

require 'rufus-json/automatic'
require 'sawyer'

require 'om_api_client/authentication'
require 'om_api_client/user'

class OM::Api::Client
  include OM::Api::Authentication
  include OM::Api::User

  attr_reader :agent

  def initialize(opts = {})
    @endpoint = opts[:endpoint] || 'https://app.organisedminds.com/'

    @agent = Sawyer::Agent.new(@endpoint) do |http|
      http.headers['content-type'] = 'application/json'
    end

    @client_id     = opts[:client_id] || raise("We need a client-id")
    @client_secret = opts[:client_secret] || raise("We need a client-secret")

    grant_type = opts[:type] || 'client_credentials'

    grant_data = {
      grant_type: grant_type,
      client_id: @client_id,
      client_secret: @client_secret,
    }
    if grant_type == 'password'
      grant_data.merge(password: opts[:password], username: opts[:username])
    end

    scopes = opts[:scopes] || [ :read ]
    response = @agent.call(:post, '/oauth/token?scope=' + scopes.join('+'), grant_data )

    @access_token = response.data.access_token

    # patch our connection
    @agent.instance_variable_get(:@conn).authorization( "Bearer", @access_token )
  end

  def get(path, data={})
    request(:get, path, data)
  end

  def post(path, data={})
    request(:post, path, data)
  end

  def put(path, data={})
    request(:put, path, data)
  end

  def delete(path, data={})
    request(:delete, path, data)
  end

  def head(path, data={})
    request(:head, path, data)
  end

  def request(method, path, data)
    options = {}
    options[:query]   = data.delete(:query) || {}
    options[:headers] = data.delete(:headers) || {}

    #if application_authenticated?
    #  options[:query].merge! application_authentication
    #end
    if accept = data.delete(:accept)
      options[:headers][:accept] = accept
    end

    @last_response = response = agent.call(method, URI.encode(path), data, options)
    response.data
  end
end
