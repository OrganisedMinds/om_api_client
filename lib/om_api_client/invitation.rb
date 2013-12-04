module OM::Api

  # Methods for the OM invitation system
  #
  module Invitation
    # Get all invitations around the current user
    def invitations(opts={})
      get('/api/invitations', opts)
    end

    # Get a single inviation
    #
    # @param id [Integer] The id of the invitation
    # @return [OM::Api::Resource] - The invitation
    #
    def invitation(id)
      get("/api/invitations/#{id}")
    end

    # Accept a single invitation
    #
    # @param id [Integer] The id of the invitation
    # @return [OM::Api::Resource] - The invitation
    #
    def accept_invitation(id)
      put("/api/invitations/#{id}/accept")
    end

    # Decline a single invitation
    #
    # @param id [Integer] The id of the invitation
    # @return [OM::Api::Resource] - The invitation
    #
    def decline_invitation(id)
      put("/api/invitations/#{id}/decline")
    end

    # Destroy an invitation
    #
    # @param id [Integer] The id of the invitation
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
