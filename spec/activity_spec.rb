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

  it "should request a play of an activity" do
    client.should_receive(:request).with(:put, "/api/activities/$id/play", {})
    client.play_activity("$id")
  end

  it "should request a pause of an activity" do
    client.should_receive(:request).with(:put, "/api/activities/$id/pause", {})
    client.pause_activity("$id")
  end

  it "should request a finish of an activity" do
    client.should_receive(:request).with(:put, "/api/activities/$id/finish", {})
    client.finish_activity("$id")
  end

  it "should request a reject of an activity" do
    client.should_receive(:request).with(:put, "/api/activities/$id/reject", {})
    client.reject_activity("$id")
  end

  it "should request a approve of an activity" do
    client.should_receive(:request).with(:put, "/api/activities/$id/approve", {})
    client.approve_activity("$id")
  end

  it "should request a accept of an activity" do
    client.should_receive(:request).with(:put, "/api/activities/$id/accept", {})
    client.accept_activity("$id")
  end

  it "should request a decline of an activity" do
    client.should_receive(:request).with(:put, "/api/activities/$id/decline", {})
    client.decline_activity("$id")
  end

  it "should request a take_back of an activity" do
    client.should_receive(:request).with(:put, "/api/activities/$id/take_back", {})
    client.take_back_activity("$id")
  end

  it "should request a take_over of an activity" do
    client.should_receive(:request).with(:put, "/api/activities/$id/take_over", {})
    client.take_over_activity("$id")
  end
end
