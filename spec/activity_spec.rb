require 'rspec_helper'

describe OM::Api::Item do
  let(:client) { OM::Api::Client.new( client_id: 1, client_secret: 2 ) }

  it "should request all activities for current user" do
    client.should_receive(:request).with(:get, "/api/activities", {})
    client.activities
  end

  it "should request all activities in workspace" do
    client.should_receive(:request).with(:get, "/api/workspaces/$id/activities", {})
    client.workspace_activities("$id")
  end

  it "should request all activities on stack" do
    client.should_receive(:request).with(:get, "/api/stacks/$id/activities", {})
    client.stack_activities("$id")
  end

  it "should request single activity" do
    client.should_receive(:request).with(:get, "/api/activities/$id", {})
    client.activity("$id")
  end

  it "should request a create of new activity in workspace" do
    client.should_receive(:request).with(:post, "/api/workspaces/$id/activities", {
      name: "foo"
    })
    client.create_workspace_activity("$id", name: "foo")
  end

  it "should request a create of new activity on stack" do
    client.should_receive(:request).with(:post, "/api/stacks/$id/activities", {
      name: "foo"
    })
    client.create_stack_activity("$id", name: "foo")
  end

  it "should request a update of an activity" do
    client.should_receive(:request).with(:put, "/api/activities/$id", {
      name: "bar"
    })
    client.update_activity("$id", name: "bar")
  end

  it "should request a destroy of an activity" do
    client.should_receive(:request).with(:delete, "/api/activities/$id", {})
    client.destroy_activity("$id")
  end
end
