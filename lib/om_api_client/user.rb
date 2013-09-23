module OM::Api::User
  def me
    get('/api/users/me')
  end

  def update_user(id, data)
    put("/api/users/#{id}", data)
  end
end
