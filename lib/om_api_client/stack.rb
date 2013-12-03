module OM::Api

  # Methods for the OM stacks
  module Stack
    # Get all stacks in workspace
    #
    # @param id [Integer] The id of the workspace
    # @param opts [Hash] Additional parameters for the query
    # @return [Array<OM::Api::Resource>] Stacks
    #
    def workspace_stacks(id, opts={})
      get("/api/workspaces/#{id}/stacks")
    end

    # Get single stack
    #
    # @param id [Integer] The id of the stack
    # @return [OM::Api::Resource] The stack
    #
    def stack(id)
      get("/api/stacks/#{id}")
    end

    # Create a stack in a workspace
    # @param id [Integer] The id of the workspace
    # @param opts [Hash] options to create a stack with
    # @option opts [String] :name The name
    # @option opts [String] :description The description
    # @return [OM::Api::Resource] Newly created stack
    #
    def create_workspace_stack(id, opts={})
      post("/api/workspaces/#{id}/stacks", opts)
    end

    # Update a stack
    # @param id [Integer] The id of the stack
    # @param opts [Hash] options to update a stack with
    # @option opts [String] :name The name
    # @option opts [String] :description The description
    # @return [OM::Api::Resource] Updated stack
    #
    def update_stack(id, opts={})
      put("/api/stacks/#{id}", opts)
    end

    # Destroy stack
    # @param id [Integer] The id of the stack
    # @return nil
    #
    def destroy_stack(id)
      delete("/api/stacks/#{id}")
    end

    # Reorder workspace stacks
    # @param workspace_id [Integer] The id of a workspace where stack is located
    # @param id [Integer] The id of the stack to reorder
    # @param opts [Hash] options to reorder a stack with
    # @option opts [Integer] :position to reorder stack to
    # @return [OM::Api::Resource] Updated stack
    #
    # @note: Does not compute
    def reorder_workspace_stacks(workspace_id, id, opts={})
      put("/api/workspaces/#{workspace_id}/stacks/#{id}/reorder", opts)
    end

    # Fetch all items off the stack
    # @param id [Integer] the id of the stack
    # @return [Array<OM::Api::Resource>] The stack items
    def stack_items(id)
      get("/api/stacks/#{id}/items")
    end

    # @param id [Integer] The id of the workspace
    # @param opts [Hash] options to find the item to inbox
    # @option opts [String] :type Type of item ("Activity" for instance)
    # @option opts [String] :id Id of the item
    #
    def create_stack_item(id, opts)
      post("/api/stacks/#{id}/items", opts)
    end
  end
end
