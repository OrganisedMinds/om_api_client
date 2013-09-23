module OM::Api::Workspace
  def workspaces
    get('/api/workspaces')
  end

  def workspace(owner_slug, slug)
    get("/api/#{owner_slug}/workspaces/#{slug}")
  end

  def create_workspace(owner_slug, name, description, settings={})
    post("/api/#{owner_slug}/workspaces", {
      name:        name,
      description: description,
      settings:    settings
    })
  end
end
