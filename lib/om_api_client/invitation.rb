module OM::Api

  # Methods for the OM invitation system
  #
  module Invitation
    # Get all invitations around the current user
    def invitations
      get('/api/invitations')
    end

    # Get a single inviation
    #
    # @params id [Integer] The id of the invitation
    # @return [Sawyer::Resource] - The invitation
    #
    def invitation(id)
      get("/api/invitations/#{id}")
    end

    # Accept a single invitation
    #
    # @params id [Integer] The id of the invitation
    # @return [Sawyer::Resource] - The invitation
    #
    def accept_invitation(id)
      put("/api/invitations/#{id}/accept")
    end

    # Decline a single invitation
    #
    # @params id [Integer] The id of the invitation
    # @return [Sawyer::Resource] - The invitation
    #
    def decline_invitation(id)
      put("/api/invitations/#{id}/decline")
    end

    # Destroy an invitation
    #
    # @params id [Integer] The id of the invitation
    # @return [Boolean] true == success
    #
    # @note Only works on invitations created by the user
    #
    def destroy_invitation(id)
      res = delete("/api/invitations/#{id}")
      res.success
    rescue
      false
    end
  end
end
