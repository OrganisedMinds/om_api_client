module OM
  module Api
    require "om_api_client/version"
  end
end

require 'faraday'
require 'faraday-cookie_jar'
require 'rufus-json/automatic'

require 'om_api_client/authentication'
require 'om_api_client/user'
require 'om_api_client/invitation'
require 'om_api_client/workspace'
require 'om_api_client/stack'
require 'om_api_client/item'
require 'om_api_client/activity'
require 'om_api_client/delegation'

require 'om_api_client/resource'

module OM::Api
  # The workhorse
  # @example
  # c = OM::Api::Client.new(client_id: "89e598...", client_secret: "10d06f...")
  class Client
    include OM::Api::Authentication
    include OM::Api::User
    include OM::Api::Invitation
    include OM::Api::Workspace
    include OM::Api::Stack
    include OM::Api::Item
    include OM::Api::Activity
    include OM::Api::Delegation

    attr_reader :agent, :last_response

    # Setup an authenticated connection to the OM Api
    #
    # @param opts [Hash] List of options
    # @option opts [String] :endpoint
    #   The endpoint to connect to;
    #   Defaults to 'https://app.organisedminds.com/'
    #
    # @option opts [String] :client_id - **required**
    #   The client-id as provided by OM
    #
    # @option opts [String] :client_secret - **required**
    #   The clien-secret as provided by OM
    #
    # @option opts [Array]  :scopes
    #   The scope(s) of the connection;
    #   Defaults to 'read', possible are 'read' and 'write'
    #
    def initialize(opts = {})
      @endpoint = opts[:endpoint] || 'https://app.organisedminds.com/'

      @client_id     = opts[:client_id] || raise("We need a client-id")
      @client_secret = opts[:client_secret] || raise("We need a client-secret")
      @scopes        = opts[:scopes] || [ :read ]

      @agent = Faraday.new(:url => @endpoint) do |faraday|
        faraday.use :cookie_jar
        faraday.request :url_encoded
        faraday.adapter *opts[:adapter] || Faraday.default_adapter
        faraday.headers['content-type'] = 'application/json'

        if opts[:debug] == true
          faraday.response :logger
        end
      end
    end

    # Perform a GET request
    #
    # @param path [String] The uri-path to request
    # @param data [Hash]   The request data
    # @return [Sawyer::Resource, Array<Sawyer::Resource>]
    #
    def get(path, data={})
      request(:get, path, data)
    end

    # Perform a POST request
    #
    # @param path [String] The uri-path to request
    # @param data [Hash]   The request data
    # @return [Sawyer::Resource, Array<Sawyer::Resource>]
    #
    def post(path, data={})
      request(:post, path, data)
    end

    # Perform a PUT request
    #
    # @param path [String] The uri-path to request
    # @param data [Hash]   The request data
    # @return [Sawyer::Resource, Array<Sawyer::Resource>]
    #
    def put(path, data={})
      request(:put, path, data)
    end

    # Perform a DELETE request
    #
    # @param path [String] The uri-path to request
    # @param data [Hash]   The request data
    # @return [Sawyer::Resource, Array<Sawyer::Resource>]
    #
    def delete(path, data={})
      request(:delete, path, data)
    end

    # Perform a HEAD request
    #
    # @param path [String] The uri-path to request
    # @param data [Hash]   The request data
    # @return [Sawyer::Resource, Array<Sawyer::Resource>]
    #
    def head(path, data={})
      request(:head, path, data)
    end

    # Perform a request
    #
    # @param method [Symbol] Request type (GET, POST, etc)
    # @param path   [String] The uri-path to request
    # @param data   [Hash]   The request data
    #
    # @return [Sawyer::Resource, Array<Sawyer::Resource>]
    #
    def request(method, path, data)
      authenticate!

      headers = {
        Authorization: "Bearer #{@access_token}"
      }.merge(data.delete(:headers) || {})

      if accept = data.delete(:accept)
        headers[:accept] = accept
      end

      @last_response = response = if [ :post, :put ].include?(method)
        agent.send(method, URI.encode(path)) do |request|
          request.headers.merge(headers)
          request.body = Rufus::Json.encode(data)
        end

      else
        agent.send(method, URI.encode(path), data) do |request|
          request.headers.merge(headers)
        end
      end

      parsed = Rufus::Json.decode(response.body)
      if parsed.is_a?(Hash)
        OM::Api::Resource.absorb(parsed)
      elsif parsed.is_a?(Array)
        parsed.map! { |i| OM::Api::Resource.absorb(i) }
      else
        parsed
      end
    end

    private :request
  end
end
