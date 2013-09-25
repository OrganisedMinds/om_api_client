module OM::Api::Authentication
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
