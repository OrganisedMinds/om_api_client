module OM::Api::Authentication
  def authenticate!
    return if authenticated?

    grant_data = {
      grant_type: 'client_credentials',
      client_id: @client_id,
      client_secret: @client_secret,
    }

    response = @agent.call(:post, '/oauth/token?scope=' + @scopes.join('+'), grant_data )

    @access_token = response.data.access_token

    # patch our connection
    @agent.instance_variable_get(:@conn).authorization( "Bearer", @access_token )
  end

  # Indicates if the client was supplied an OAuth
  # access token
  #
  # @return [Boolean]
  def authenticated?
    !!@access_token
  end

  # Indicates if the client has OAuth Application
  # client_id and secret credentials to make anonymous
  # requests at a higher rate limit
  #
  # @return Boolean
  #
  def application_authenticated?
    !!application_authentication
  end

  # Get an overview of the current rate-limit
  #
  # @return [Sawyer::Resource]
  #
  def rate_limit
    get("/api/me/rate_limit")
  end

  private

  def application_authentication
    if @client_id && @client_secret
      {
        :client_id     => @client_id,
        :client_secret => @client_secret
      }
    end
  end
end
