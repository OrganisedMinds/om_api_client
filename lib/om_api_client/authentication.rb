module OM::Api::Authentication
  # Indicates if the client was supplied an OAuth
  # access token
  #
  # @see http://developer.github.com/v3/#authentication
  # @return [Boolean]
  def authenticated?
    !!@access_token
  end

  # Indicates if the client has OAuth Application
  # client_id and secret credentials to make anonymous
  # requests at a higher rate limit
  #
  # @see http://developer.github.com/v3/#unauthenticated-rate-limited-requests
  # @return Boolean
  def application_authenticated?
    !!application_authentication
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
