module OM::Api

  # Methods for the OM activities
  #
  module Activity
    # Get all activities for the current user
    #
    # @param opts [Hash] Additional parameters for the query
    # @return [Array<OM::Api::Resource>] - Activities
    #
    def activities(opts={})
      get('/api/activities', opts)
    end

    # Get a single activity
    #
    # @param id [Integer] The id of the activity
    # @return [OM::Api::Resource] - The activity
    #
    def activity(id)
      get("/api/activities/#{id}")
    end

    # Create a activity
    #
    # @param opts [Hash] options to create a activity with
    # @option opts [String] :name The name
    # @option opts [String] :description The description
    # @option opts [String] :target_date The deadline
    # @option opts [String] :alarm The reminder date
    # @return [OM::Api::Resource] - Newly created activity
    #
    def create_activity(opts={})
      post("/api/activities", opts)
    end

    # Update a activity
    #
    # @param id [Integer] The id of the activity
    # @param opts [Hash] options to update a activity with
    # @option opts [String] :name The name
    # @option opts [String] :description The description
    # @return [OM::Api::Resource] - Updated activity
    #
    def update_activity(id, opts={})
      put("/api/activities/#{id}", opts)
    end

    # Destroy a activity
    #
    # @param id [Integer] The id of the activity
    # @return nil
    #
    def destroy_activity(id)
      delete("/api/activities/#{id}")
    end

    %w[play pause finish delete reject approve accept decline take_back take_over].each do |action|
      define_method "#{action}_activity" do |id|
        put("/api/activities/#{id}/#{action}")
      end
    end

    # Update a activity
    #
    # @param id [Integer] The id of the activity
    # @param opts [Hash] options to update a activity with
    # @option opts [String] :delegee The slug of the delegee
    # @option opts [String] :note The delegation message
    # @option opts [Boolean] :sign_off Should the current assignee sign off on
    #   the delegation
    # @return [OM::Api::Resource] - Updated activity
    #
    def delegate_activity(id, opts)
      opts[:delegee_slug] ||= opts.delete(:slug) || opts.delete(:delegee)
      opts[:sign_off]       = opts[:sign_off] == true ? 'true' : 'false'

      put("/api/activities/#{id}/delegate", opts)
    end

    # Update a activity
    #
    # @param id [Integer] The id of the activity
    # @param opts [Hash] options to update a activity with
    # @option opts [String] :from The id of the source workspace
    # @option opts [String] :to   The id of the destination workspace
    # @return [OM::Api::Resource] - Updated activity
    def move_activity(id, opts)
      opts[:source_id]    = opts.delete(:from)
      opts[:workspace_id] = opts.delete(:to)

      put("/api/activities/#{id}/move", opts)
    end

    def update_activity_blox(source_id, id, opts)
      put("/api/activities/#{source_id}/blox/#{id}", opts)
    end
  end
end
