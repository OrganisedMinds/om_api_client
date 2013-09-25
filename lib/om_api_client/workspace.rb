module OM::Api::Workspace
  def workspaces
    get('/api/workspaces')
  end

  def workspace(id)
    get("/api/workspaces/#{id}")
  end

  def create_workspace(owner_slug, name, description, settings={})
    post("/api/workspaces", {
      name:        name,
      description: description,
      settings:    settings
    })
  end
end
