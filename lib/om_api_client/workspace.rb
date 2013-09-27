module OM::Api

  # Methods for the OM workspaces
  #
  module Workspace
    # Get all workspaces for the current user
    #
    # @param opts [Hash] Additional parameters for the query
    # @return [Array<OM::Api::Resource>] - Workspaces
    #
    def workspaces(opts={})
      get('/api/workspaces')
    end

    # Get a single workspace
    #
    # @param id [Integer] The id of the workspace
    # @return [OM::Api::Resource] - The workspace
    #
    def workspace(id)
      get("/api/workspaces/#{id}")
    end

    # Create a workspace
    #
    # @param opts [Hash] options to create a workspace with
    # @option opts [String] :name The name
    # @option opts [String] :description The description
    # @option opts [Hash]  :setting Workspace settings
    # @return [OM::Api::Resource] - Newly created workspace
    #
    def create_workspace(opts={})
      post("/api/workspaces", opts)
    end

    # Update a workspace
    #
    # @param id [Integer] The id of the workspace
    # @param opts [Hash] options to update a workspace with
    # @option opts [String] :name The name
    # @option opts [String] :description The description
    # @option opts [Hash]  :setting Workspace settings
    # @return [OM::Api::Resource] - Updated workspace
    #
    def update_workspace(id, opts={})
      put("/api/workspaces/#{id}", opts)
    end

    # Destroy a workspace
    #
    # @param id [Integer] The id of the workspace
    # @param archive_items [Boolean] true == archive items of the workspace in
    #   owner's personal workspace archive
    # @return nil
    #
    def destroy_workspace(id, archive_items=false)
      delete("/api/workspaces/#{id}", {
        archive_items: archive_items
      })
    end

    # Invite user(s) to workspace
    # @param id [Integer] Workspace id
    # @param opts [Hash] options to invite user(s) with
    # @option opts [Integer, Array<Integer>] :id Array of ids or single id of
    #   users to invite
    # @option opts [String, Array<String>] :email Array of emails or single
    #   email of users to invite
    # @return [OM::Api::Resource, Array<OM::Api::Resource>] Invited user or
    #   an array of invited users
    #
    def invite_user_to_workspace(id, opts={})
      post("/api/workspaces/#{id}/invite", opts)
    end

    # Leave workspace
    # @param id [Integer] Workspace id
    # @return nil
    #
    def leave_workspace(id)
      delete("/api/workspaces/#{id}/leave")
    end

    # Remove workspace member
    # @param id [Integer] Workspace id
    # @param member_id [Integer] The id of workspace member to remove
    # @return nil
    #
    def remove_workspace_member(id, member_id)
      delete("/api/workspaces/#{id}/members/#{member_id}")
    end
  end
end
