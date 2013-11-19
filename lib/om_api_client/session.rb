module OM::Api

  # Methods for OM API session control
  #
  module Session
    # Get an overview of the current rate-limit
    #
    # @return [OM::Api::Resource]
    #
    def rate_limit
      get("/api/session/rate_limit")
    end

    def context
      get("/api/session/context")
    end

    def switch_context(type, slug)
      put("/api/session/switch_context", { type: type, slug: slug })
    end
  end
end
