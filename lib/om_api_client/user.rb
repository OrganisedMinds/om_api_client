module OM::Api::User
  def me
    get('/api/user')
  end

  def update_user(data)
    put("/api/user", { user: data })
  end

  def user_following(type)
    get('/api/user/following', { type: type })
  end
end
