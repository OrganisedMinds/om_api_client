module OM::Api

  # Methods for the user and me API
  #
  module User

    # Get the current user
    #
    # @return [Sawyer::Resource]
    #
    def me
      get('/api/me')
    end
    alias_method :user, :me

    # Update the current user
    #
    # @return [Sawyer::Resource] The updated user object
    #
    def update_me(data)
      put("/api/me", { user: data })
    end

    # Get a list of things the current user follows.
    #
    # @param type [Symbol, String] class name to filter the reuslts by
    #             eg: Activity or User
    # @return [Array<Sawyer::Resource>]
    #
    def me_follows(type=nil)
      get('/api/me/follows', { type: type })
    end

    # Get a list of things following the current user.
    #
    # @param type [Symbol, String] class name to filter the reuslts by
    #             eg: Activity or User
    # @return [Array<Sawyer::Resource>]
    #
    def follows_me(type=nil)
      get('/api/me/followings', { type: type })
    end
    alias_method :me_following, :follows_me

    # Get a list of other users connected to this user, either by sharing a
    # Workspace or having forged a collaboration relationship (following)
    #
    # @return [Array<Sawyer::Resource>] List of OM users.
    #
    def my_connections
      get("/api/me/connections")
    end

    # Get all the users available to this user (same as #my_connections)
    #
    def users
      get("/api/users")
    end

    # Get a single user
    #
    # @param slug [String] An OM user slug
    # @note The API doest not accept ID as a way to find users, you must know
    # the slug
    # @return [Sawyer::Resource]
    #
    def user(slug)
      get("/api/users/#{slug}")
    end

    # Send a collaboration invite to the user
    #
    # @param slug [String] An OM user slug
    # @return [Sawyer::Resource] The invitation
    #
    def collaborate_with(slug)
      put("/api/users/#{slug}/collaborate")
    end
  end
end
