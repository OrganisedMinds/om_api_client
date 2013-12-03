require 'rspec_helper'

describe OM::Api::Activity do
  let(:client) { OM::Api::Client.new( client_id: 1, client_secret: 2 ) }
  let(:id) { "$id" }

  it "should request user's activities" do
    client.should_receive(:request).with(:get, "/api/activities", {})
    client.activities
  end

  it "should request a single activity" do
    client.should_receive(:request).with(:get, "/api/activities/$id", {})
    client.activity(id)
  end

  it "should request a create of a activity" do
    client.should_receive(:request).with(:post, "/api/activities", {name: "foo"})
    client.create_activity(name: "foo")
  end

  it "should request a update of a worksapce" do
    client.should_receive(:request).with(:put, "/api/activities/$id", {name: "bar"})
    client.update_activity(id, name: "bar")
  end

  it "should request a destroy of a activity" do
    client.should_receive(:request).with(:delete, "/api/activities/$id", {})

    client.destroy_activity(id)
  end

  %w[play pause finish delete reject approve accept decline take_back take_over].each do |action|
    it "should request an activity to #{action}" do
      client.should_receive(:request).with(:put, "/api/activities/$id/#{action}", {})
      client.send(:"#{action}_activity", id)
    end
  end

  it "should request a delegation of the activity" do
    client.should_receive(:request).with(:put, "/api/activities/$id/delegate", {
      delegee_slug: "$slug",
      note: "Note",
      sign_off: "true"
    })

    client.delegate_activity(id, delegee: "$slug", note: "Note", sign_off: true)
  end

  it "should request an activity move" do
    client.should_receive(:request).with(:put, "/api/activities/$id/move", {
      source_id: "$source", workspace_id: "$destination"
    })
    client.move_activity(id, { from: "$source", to: "$destination" })
  end
end
