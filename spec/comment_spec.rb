require 'rspec_helper'

describe OM::Api::Comment do
  let(:client) { OM::Api::Client.new( client_id: 1, client_secret: 2 ) }
  let(:activity_id) { "$activity_id" }
  let(:id) { "$id" }

  it "should request all comments on a activity" do
    client.should_receive(:request).with(:get, "/api/activities/$activity_id/comments", {})
    client.activity_comments(activity_id)
  end

  it "should request single comment" do
    client.should_receive(:request).with(:get, "/api/comments/$id", {})
    client.comment(id)
  end

  it "should request create of comment on activity" do
    client.should_receive(:request).with(:post, "api/activities/$activity_id/comments", body: "foo")
    client.create_activity_comment(activity_id, body: "foo")
  end

  it "should request an update of a sigle comment" do
    client.should_receive(:request).with(:put, "/api/comments/$id", body: "new body")
    client.update_comment(id, body: "new body")
  end

  it "should request a destroy od a single comment" do
    client.should_receive(:request).with(:delete, "/api/comments/$id", {})
    client.destroy_comment(id)
  end
end
