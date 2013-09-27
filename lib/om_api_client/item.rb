module OM::Api

  # Methods for the OM items
  module Item
    # Get all items for current user
    #
    # @param opts [Hash] Additional parameters for the query
    # @return [Array<OM::Api::Resource>] - Items
    #
    def items(opts={})
      get("/api/items")
    end

    # Get all items in workspace
    #
    # @param id [Integer] The id of the workspace
    # @param opts [Hash] Additional parameters for the query
    # @return [Array<OM::Api::Resource>] - Items
    #
    def workspace_items(id, opts={})
      get("/api/workspaces/#{id}/items")
    end

    # Get all items on given stack
    #
    # @param id [Integer] The id of the stack
    # @param opts [Hash] Additional parameters for the query
    # @return [Array<OM::Api::Resource>] - Items
    #
    def stack_items(id, opts={})
      get("/api/stacks/#{id}/items")
    end

    # Get a single item
    #
    # @param id [Integer] The id of the item
    # @return [OM::Api::Resource] - The item
    #
    def item(id)
      get("/api/items/#{id}")
    end

    # Create new item in inbox of a workspace
    #
    # @param id [Integer] The id of the workspace
    # @param opts [Hash] options to create an item with
    # @option opts [String] :name The name
    # @option opts [String] :description The description
    # @return [Sawyer::Resource] - Newly created item
    #
    def create_workspace_item(id, opts={})
      post("/api/workspaces/#{id}/items", opts)
    end

    # Create new item on given stack
    #
    # @param id [Integer] The id of the stack
    # @param opts [Hash] options to create an item with
    # @option opts [String] :name The name
    # @option opts [String] :description The description
    # @return [OM::Api::Resource] - Newly created item
    #
    def create_stack_item(id, opts={})
      post("/api/stacks/#{id}/items", opts)
    end

    # Update an item
    #
    # @param id [Integer] The id of the item
    # @param opts [Hash] options to update an item with
    # @option opts [String] :name The name
    # @option opts [String] :description The description
    # @return [OM::Api::Resource] - Updated item
    #
    def update_item(id, opts={})
      put("/api/items/#{id}", opts)
    end

    # Destroy an item
    #
    # @param id [Integer] The id of the item
    # @return nil
    #
    def destroy_item(id)
      delete("/api/items/#{id}")
    end

    # Reorder items on stack
    # @param stack_id [Integer] The id of a stack where item should be moved to
    # @param id [Integer] The id of the item to reorder
    # @param opts [Hash] options to reorder a item with
    # @option opts [Integer] :position to reorder item to (bottom == 0)
    # @return [OM::Api::Resource] - Updated stack
    # @note Item can be moved on another stack. If no position is given item
    #   will be put on the top of the stack
    #
    def reorder_stack_items(stack_id, id, opts={})
      put("/api/stacks/#{stack_id}/items/#{id}/reorder", opts)
    end

    # Move item to workspace
    # @param workspace_id [Integer] The id of the workspace where item is
    #   located
    # @param id [Integer] The id of the item
    # @param opts [Hash] options to move a item with
    # @option opts [Integer] :new_workspace_id - The id of the workspace to
    #   move item to
    # @return [OM::Api::Resource] - The item
    # @note Item will be placed on the top of inbox in given a workspace
    def move_workspace_item(workspace_id, id, opts={})
      put("/api/workspaces/#{workspace_id}/items/#{id}/move", opts)
    end
  end
end
