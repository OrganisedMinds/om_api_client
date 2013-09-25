require 'rspec_helper'

describe OM::Api::Delegation do
  let(:client) { OM::Api::Client.new( client_id: 1, client_secret: 2 ) }

  it "should request the users delegations" do
    client.should_receive(:request).with(:get, "/api/delegations", {})
    client.delegations
  end

  it "should request the users pending delegations" do
    client.should_receive(:request).with(:get, "/api/delegations/pending", {})
    client.pending_delegations
  end

  it "should request the users outgoing delegations" do
    client.should_receive(:request).with(:get, "/api/delegations/outgoing", {})
    client.outgoing_delegations
  end

  it "should request the users pending outgoing delegations" do
    client.should_receive(:request).with(:get, "/api/delegations/outgoing/pending", {})
    client.pending_outgoing_delegations
  end

  it "should request the users incoming delegations" do
    client.should_receive(:request).with(:get, "/api/delegations/incoming", {})
    client.incoming_delegations
  end

  it "should request the users pending incoming delegations" do
    client.should_receive(:request).with(:get, "/api/delegations/incoming/pending", {})
    client.pending_incoming_delegations
  end

  it "should request a single delegation" do
    client.should_receive(:request).with(:get, "/api/delegations/$id", {})
    client.delegation("$id")
  end

  it "should request accept on a delegation" do
    client.should_receive(:request).with(:put, "/api/delegations/$id/accept", {})
    client.accept_delegation("$id")
  end

  it "should request decline on a delegation" do
    client.should_receive(:request).with(:put, "/api/delegations/$id/decline", { note: "$note" } )
    client.decline_delegation("$id", "$note")
  end

  it "should request redelegate"  do
    client.should_receive(:request).with(:post, "/api/delegations/$id/redelegate", { slug: "$slug", note: "$note" })
    client.redelegate("$id", slug: "$slug", note: "$note")
  end

  it "should raise when no slug or email is provided on redelegation"  do
    expect {
      client.redelegate("$id")
    }.to raise_error(RuntimeError, "No delegation target")
  end
end
