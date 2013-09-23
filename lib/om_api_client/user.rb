module OM::Api::User
  def me
    get('/api/users/me')
  end
end
