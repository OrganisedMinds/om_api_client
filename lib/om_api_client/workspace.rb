module OM::Api

  # Methods for the OM workspaces
  #
  module Workspace
    # Get all worksapces for the current user
    def workspaces
      get('/api/workspaces')
    end

    # Get a single workspace where current user belongs to
    #
    # @param id [Integer] The id of the workspace
    # @return [Sawyer::Resource] - The workspace
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
    #
    def create_workspace(opts={})
      post("/api/workspaces", opts)
    end

    # Update a workspace
    #
    # @param id [Integer] The id of the worksapce
    # @param opts [Hash] options to update a workspace with
    # @option opts [String] :name The name
    # @option opts [String] :description The description
    # @option opts [Hash]  :setting Workspace settings
    #
    def update_workspace(id, opts={})
      put("/api/workspaces/#{id}", opts)
    end

    # Destroy a workspace
    #
    # @param id [Integer] The id of the worksapce
    # @param archive_items [Boolean] true == archive items of the workspace in
    #   owner's personal workspace archive
    #
    def destroy_workspace(id, archive_items=false)
      delete("/api/workspaces/#{id}", {
        archive_items: archive_items
      })
    end
  end
end
