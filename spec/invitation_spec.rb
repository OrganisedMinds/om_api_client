require 'rspec_helper'

describe OM::Api::Invitation do
  let(:client) { OM::Api::Client.new( client_id: 1, client_secret: 2 ) }

  it "should request the users invitations" do
    client.should_receive(:request).with(:get, "/api/invitations", {})
    client.invitations
  end

  it "should request a single invitation" do
    client.should_receive(:request).with(:get, "/api/invitations/$id", {})
    client.invitation("$id")
  end

  it "should request an accept for a invitation" do
    client.should_receive(:request).with(:put, "/api/invitations/$id/accept", {})
    client.accept_invitation("$id")
  end

  it "should request a decline for an invitation" do
    client.should_receive(:request).with(:put, "/api/invitations/$id/decline", {})
    client.decline_invitation("$id")
  end

  it "should request a destroy for an invitation" do
    client.should_receive(:request).with(:delete, "/api/invitations/$id", {})
    client.destroy_invitation("$id")
  end
end
