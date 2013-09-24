module OM::Api::User
  def me
    get('/api/me')
  end
  alias_method :user, :me

  def update_me(data)
    put("/api/me", { user: data })
  end

  def me_follows(type=nil)
    get('/api/me/follows', { type: type })
  end

  def my_connections
    get("/api/me/connections")
  end

  def rate_limit
    get("/api/me/rate_limit")
  end

  def users(slug=nil)
    get("/api/users" + (slug ? "/#{slug}" : ""))
  end
end
