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
      get('/api/workspaces', opts)
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

    def invited_workspaces(opts={})
      get("/api/workspaces/invited", opts)
    end

    def invite_to_workspace(id, opts)
      opts[:cc] = (opts[:cc] == true ? 'true' : 'false')
      if opts.has_key?(:email)
        opts[:email] = [ opts[:email] ] unless opts[:email].is_a?(Array)
      end
      if opts.has_key?(:slug)
        opts[:slug] = [ opts[:slug] ] unless opts[:slug].is_a?(Array)
      end

      post("/api/workspaces/#{id}/invitation", opts)
    end

    # Return the inbox of the workspace
    #
    # @param id [Integer] The id of the workspace
    # @return [OM::Api::Resource] the inbox
    #
    def workspace_inbox(id)
      get("/api/workspaces/#{id}/inbox")
    end

    # Add an item on the workspace inbox
    #
    # @param id [Integer] The id of the workspace
    # @param opts [Hash] options to find the item to inbox
    # @option opts [String] :type Type of item ("Activity" for instance)
    # @option opts [String] :id Id of the item
    #
    def workspace_inbox_add(id, opts)
      put("/api/workspaces/#{id}/inbox", opts)
    end

    # Return the items of the workspace
    #
    # @param id [Integer] The id of the workspace
    # @return [Array<OM::Api::Resource>] the items
    #
    def workspace_items(id, opts={})
      get("/api/workspaces/#{id}/items", opts)
    end
  end
end
