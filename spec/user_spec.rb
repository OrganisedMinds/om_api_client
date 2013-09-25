require 'rspec_helper'

describe OM::Api::User do
  let(:client) { OM::Api::Client.new( client_id: 1, client_secret: 2 ) }

  describe "Me" do
    it "should request me" do
      client.should_receive(:request).with(:get, "/api/me", {})
      client.me
    end

    it "should update me" do
      client.should_receive(:request).with(:put, "/api/me", { user: { first_name: "Jaap" } })
      client.update_me( first_name: "Jaap" )
    end

    it "should request my connections" do
      client.should_receive(:request).with(:get, "/api/me/connections", {})
      client.my_connections
    end

    it "should request what I follow" do
      client.should_receive(:request).with(:get, "/api/me/follows", { type: nil })
      client.me_follows
    end

    it "should request what I follow, limited to type" do
      client.should_receive(:request).with(:get, "/api/me/follows", { type: :Activity })
      client.me_follows(:Activity)
    end

    it "should request my followers" do
      client.should_receive(:request).with(:get, "/api/me/following", { type: nil })
      client.me_following
    end

    it "should request my followers, limited to type" do
      client.should_receive(:request).with(:get, "/api/me/following", { type: :User })
      client.me_following(:User)
    end
  end

  describe "The Others" do
    it "should request a list of users" do
      client.should_receive(:request).with(:get, "/api/users", {})
      client.users
    end

    it "should request a single user" do
      client.should_receive(:request).with(:get, "/api/users/$slug", {})
      client.user("$slug")
    end

    it "should request a collaboration invite" do
      client.should_receive(:request).with(:put, "/api/users/$slug/collaborate", {})
      client.collaborate_with("$slug")
    end
  end
end
