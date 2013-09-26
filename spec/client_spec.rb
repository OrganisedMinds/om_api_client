require 'rspec_helper'

describe OM::Api::Client do
  describe "Options" do
    it "should insist on a client-id" do
      expect {
        OM::Api::Client.new(client_secret: 1)
      }.to raise_error(RuntimeError, "We need a client-id")
    end

    it "should insist on a client-secret" do
      expect {
        OM::Api::Client.new(client_id: 1)
      }.to raise_error(RuntimeError, "We need a client-secret")
    end

    it "should accept an alternative endpoint" do
      endpoint = "news://alt.endpoint"
      client   = OM::Api::Client.new(endpoint: endpoint, client_id: 1, client_secret: 1)
      client.instance_variable_get(:@endpoint).should == endpoint
    end

    it "should set a default 'read' scope" do
      client= OM::Api::Client.new(client_id: 1, client_secret: 1)
      client.instance_variable_get(:@scopes).should == [ :read ]
    end

    it "should accept alternative scopes" do
      scopes = %w[ read write ]
      client = OM::Api::Client.new(scopes: scopes, client_id: 1, client_secret: 1)
      client.instance_variable_get(:@scopes).should == scopes
    end
  end

  describe "Requests" do
    let(:client) { OM::Api::Client.new( client_id: 1, client_secret: 2 ) }
    it "should perform GET requests" do
      client.should_receive(:request).with(:get, "/foo", {})
      client.get("/foo")
    end

    it "should perform POST requests" do
      client.should_receive(:request).with(:post, "/foo", { data: 1 })
      client.post("/foo", data: 1)
    end

    it "should perform PUT requests" do
      client.should_receive(:request).with(:put, "/foo", { data: 1 })
      client.put("/foo", data: 1)
    end

    it "should perform DELETE requests" do
      client.should_receive(:request).with(:delete, "/foo", {})
      client.delete("/foo")
    end

    it "should perform HEAD requests" do
      client.should_receive(:request).with(:head, "/foo", {})
      client.head("/foo")
    end
  end

  describe "#request" do
    before(:all) do
      @stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.post('/oauth/token?scope=read') { [200, {}, '{"access_token":"meh"}'] }
        stub.get('/single') { [200, {}, '{"single":"resource"}'] }
        stub.get('/multi') { [200, {}, '[{"single":"resource"},{"single":"resource"}]'] }
      end
    end

    let(:client) {
      OM::Api::Client.new( client_id: 1, client_secret: 2, adapter: [ :test, @stubs ] )
    }

    it "should turn response into an OM::Api::Resource" do
      client.get('/single').should be_kind_of(OM::Api::Resource)
    end

    it "should turn array-responses into arrays of OM::Api::Resource" do
      array = client.get('/multi')
      array.should be_kind_of(Array)
      array.should_not be_any { |i| !i.kind_of?(OM::Api::Resource) }
    end
  end
end
