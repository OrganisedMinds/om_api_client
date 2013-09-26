module OM::Api::Workspace
  def workspaces
    get('/api/workspaces')
  end

  def workspace(id)
    get("/api/workspaces/#{id}")
  end

  def create_workspace(opts={})
    post("/api/workspaces", {
      name:        opts[:name],
      description: opts[:description],
      setting:     opts[:setting]
    })
  end

  def update_workspace(id, opts={})
    put("/api/workspaces/#{id}", {
      name:        opts[:name],
      description: opts[:description],
      setting:     opts[:setting]
    })
  end

  def destroy_workspace(id, opts={})
    delete("/api/workspaces/#{id}", {
      archive_items: opts[:archive_items] || false
    })
  end
end
