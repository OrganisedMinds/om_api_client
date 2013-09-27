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

    # Play an activity
    # @param id [Integer] The id of the activity
    # @return [OM::Api::Resource] The activity
    #
    def play_activity(id)
      put("/api/activities/#{id}/play")
    end

    # Pause an activity
    # @param id [Integer] The id of the activity
    # @return [OM::Api::Resource] The activity
    #
    def pause_activity(id)
      put("/api/activities/#{id}/pause")
    end

    # Finish an activity
    # @param id [Integer] The id of the activity
    # @return [OM::Api::Resource] The activity
    #
    def finish_activity(id)
      put("/api/activities/#{id}/finish")
    end
 
    # Reject an activity
    # @param id [Integer] The id of the activity
    # @return [OM::Api::Resource] The activity
    #
    def reject_activity(id)
      put("/api/activities/#{id}/reject")
    end
 
    # Approve an activity
    # @param id [Integer] The id of the activity
    # @return [OM::Api::Resource] The activity
    #
    def approve_activity(id)
      put("/api/activities/#{id}/approve")
    end
 
    # Accept an activity
    # @param id [Integer] The id of the activity
    # @return [OM::Api::Resource] The activity
    #
    def accept_activity(id)
      put("/api/activities/#{id}/accept")
    end
 
    # Decline an activity
    # @param id [Integer] The id of the activity
    # @return [OM::Api::Resource] The activity
    #
    def decline_activity(id)
      put("/api/activities/#{id}/decline")
    end
 
    # Take back an activity
    # @param id [Integer] The id of the activity
    # @return [OM::Api::Resource] The activity
    #
    def take_back_activity(id)
      put("/api/activities/#{id}/take_back")
    end
 
    # Take over an activity
    # @param id [Integer] The id of the activity
    # @return [OM::Api::Resource] The activity
    #
    def take_over_activity(id)
      put("/api/activities/#{id}/take_over")
    end
  end
end
