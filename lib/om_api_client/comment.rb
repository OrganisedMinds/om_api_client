module OM::Api

  # Methods for the OM comments
  #
  module Comment
    def activity_comments(activity_id, opts={})
      get("/api/activities/#{activity_id}/comments", opts)
    end

    def comment(id)
      get("/api/comments/#{id}")
    end

    # Create an activity comment
    #
    # @param activity_id [Integer] The id of the activity
    # @param opts [Hash] options to update a comment with
    # @option opts [String] :body New body for the comment
    # @return [OM::Api::Resource] Newly created comment
    #
    def create_activity_comment(activity_id, opts={})
      post("api/activities/#{activity_id}/comments", opts)
    end

    # Update a comment
    #
    # @param id [Integer] The id of the comment
    # @param opts [Hash] options to update a comment with
    # @option opts [String] :body New body for the comment
    # @return [OM::Api::Resource] Updated comment
    #
    def update_comment(id, opts={})
      put("/api/comments/#{id}", opts)
    end

    # Destroy a comment
    #
    # @param id [Integer] The id of the comment
    # @return nil
    #
    def destroy_comment(id)
      delete("/api/comments/#{id}")
    end
  end
end
