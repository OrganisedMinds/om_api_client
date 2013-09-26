require 'rspec_helper'

describe OM::Api::Stack do
  let(:client) { OM::Api::Client.new( client_id: 1, client_secret: 2 ) }

  it "should request all stack in a workspace" do
    client.should_receive(:request).with(:get, "/api/workspaces/$id/stacks", {})
    client.workspace_stacks("$id")
  end

  it "should request single stack" do
    client.should_receive(:request).with(:get, "/api/stacks/$id", {})
    client.stack("$id")
  end

  it "should request create of new stack in a workspace" do
    client.should_receive(:request).with(:post, "/api/workspaces/$id/stacks",{
      name: "foo"
    })
    client.create_workspace_stack("$id", name: "foo")
  end

  it "should request update of a stack" do
    client.should_receive(:request).with(:put, "/api/stacks/$id", {
      name: "foo"
    })
    client.update_stack("$id", name: "foo")
  end

  it "should request destroy of a stack" do
    client.should_receive(:request).with(:delete, "/api/stacks/$id", {})
    client.destroy_stack("$id")
  end

  it "should request reorder of stacks in workspace" do
    client.should_receive(:request).with(:put, "/api/workspaces/$ws_id/stacks/$id/reorder", {
      position: 0
    })
    client.reorder_worksapce_stacks("$ws_id", "$id", position: 0)
  end
end
