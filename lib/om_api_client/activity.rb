module OM::Api

  # Methods for the OM activities
  module Activity
    # Get all activities for current user
    #
    # @param opts [Hash] Additional parameters for the query
    # @return [Array<OM::Api::Resource>] - Activities
    #
    def activities(opts={})
      get("/api/activities")
    end

    # Get all activities in workspace
    #
    # @param id [Integer] The id of the workspace
    # @param opts [Hash] Additional parameters for the query
    # @return [Array<OM::Api::Resource>] - Activities
    #
    def workspace_activities(id, opts={})
      get("/api/workspaces/#{id}/activities")
    end

    # Get all activities on given stack
    #
    # @param id [Integer] The id of the stack
    # @param opts [Hash] Additional parameters for the query
    # @return [Array<OM::Api::Resource>] - Activities
    #
    def stack_activities(id, opts={})
      get("/api/stacks/#{id}/activities")
    end

    # Get a single activity
    #
    # @param id [Integer] The id of the activity
    # @return [OM::Api::Resource] - The activity
    #
    def activity(id)
      get("/api/activities/#{id}")
    end

    # Create new activity in inbox of a workspace
    #
    # @param id [Integer] The id of the workspace
    # @param opts [Hash] options to create an activity with
    # @option opts [String] :name The name
    # @option opts [String] :description The description
    # @return [Sawyer::Resource] - Newly created activity
    #
    def create_workspace_activity(id, opts={})
      post("/api/workspaces/#{id}/activities", opts)
    end

    # Create new activity on given stack
    #
    # @param id [Integer] The id of the stack
    # @param opts [Hash] options to create an activity with
    # @option opts [String] :name The name
    # @option opts [String] :description The description
    # @return [OM::Api::Resource] - Newly created activity
    #
    def create_stack_activity(id, opts={})
      post("/api/stacks/#{id}/activities", opts)
    end

    # Update an activity
    #
    # @param id [Integer] The id of the activity
    # @param opts [Hash] options to update an activity with
    # @return [OM::Api::Resource] - Updated activity
    #
    def update_activity(id, opts={})
      put("/api/activities/#{id}", opts)
    end

    # Destroy an activity
    #
    # @param id [Integer] The id of the activity
    # @return nil
    #
    def destroy_activity(id)
      delete("/api/activities/#{id}")
    end
  end
end
