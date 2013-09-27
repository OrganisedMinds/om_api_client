require 'rspec_helper'

describe OM::Api::Item do
  let(:client) { OM::Api::Client.new( client_id: 1, client_secret: 2 ) }

  it "should request all items for current user" do
    client.should_receive(:request).with(:get, "/api/items", {})
    client.items
  end

  it "should request all items in workspace" do
    client.should_receive(:request).with(:get, "/api/workspaces/$id/items", {})
    client.workspace_items("$id")
  end

  it "should request all items on stack" do
    client.should_receive(:request).with(:get, "/api/stacks/$id/items", {})
    client.stack_items("$id")
  end

  it "should request single item" do
    client.should_receive(:request).with(:get, "/api/items/$id", {})
    client.item("$id")
  end

  it "should request a create of new item in workspace" do
    client.should_receive(:request).with(:post, "/api/workspaces/$id/items", {
      name: "foo"
    })
    client.create_workspace_item("$id", name: "foo")
  end

  it "should request a create of new item on stack" do
    client.should_receive(:request).with(:post, "/api/stacks/$id/items", {
      name: "foo"
    })
    client.create_stack_item("$id", name: "foo")
  end

  it "should request a update of an item" do
    client.should_receive(:request).with(:put, "/api/items/$id", {
      name: "bar"
    })
    client.update_item("$id", name: "bar")
  end

  it "should request a destroy of an item" do
    client.should_receive(:request).with(:delete, "/api/items/$id", {})
    client.destroy_item("$id")
  end

  it "should request a reorder of an item on stack" do
    client.should_receive(:request).with(:put, "/api/stacks/$stack_id/items/$id/reorder", {
      position: 0
    })
    client.reorder_stack_items("$stack_id", "$id", position: 0)
  end

  it "should request a move of an item to a workspace" do
    client.should_receive(:request).with(:put, "/api/workspaces/$workspace_id/items/$id/move",
      new_workspace_id: "$new_ws_id"
    )
    client.move_workspace_item("$workspace_id", "$id", new_workspace_id: "$new_ws_id")
  end
end
