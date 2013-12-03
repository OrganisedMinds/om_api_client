require 'rspec_helper'

describe OM::Api::Workspace do
  let(:client) { OM::Api::Client.new( client_id: 1, client_secret: 2 ) }
  let(:id) { "$id" }

  it "should request user's workspaces" do
    client.should_receive(:request).with(:get, "/api/workspaces", {})
    client.workspaces
  end

  it "should request a single workspace" do
    client.should_receive(:request).with(:get, "/api/workspaces/$id", {})
    client.workspace(id)
  end

  it "should request workspace where user is invited" do
    client.should_receive(:request).with(:get, "/api/workspaces/invited", {})
    client.invited_workspaces
  end

  it "should request a workspace invitation" do
    email = Faker::Internet.email

    client.should_receive(:request).with(
      :post, "/api/workspaces/$id/invitation", { email: [ email ], cc: "false" }
    )

    client.invite_to_workspace(id, email: email)
  end

  it "should request a create of a workspace" do
    client.should_receive(:request).with(:post, "/api/workspaces", {name: "foo"})
    client.create_workspace(name: "foo")
  end

  it "should request a update of a worksapce" do
    client.should_receive(:request).with(:put, "/api/workspaces/$id", {name: "bar"})
    client.update_workspace(id, name: "bar")
  end

  it "should request a destroy of a workspace" do
    client.should_receive(:request).with(:delete, "/api/workspaces/$id", {
      archive_items: true
    })

    client.destroy_workspace(id, true)
  end

  it "should should defaults destroy without archiving" do
    client.should_receive(:request).with(:delete, "/api/workspaces/$id", {
      archive_items: false
    })

    client.destroy_workspace(id)
  end

  it "should request a workspace inbox" do
    client.should_receive(:request).with(:get, "/api/workspaces/$id/inbox", {})
    client.workspace_inbox(id)
  end

  it "should create an item on the inbox" do
    client.should_receive(:request).with(:put, "/api/workspaces/$id/inbox", { type: "Activity", id: 12 } )
    client.workspace_inbox_add(id, type: "Activity", id: 12)
  end
end
