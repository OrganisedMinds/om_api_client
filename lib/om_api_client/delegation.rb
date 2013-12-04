module OM::Api

  # Methods for the OM delegation system
  #
  module Delegation

    # Get a list of delegations for the user
    #
    # @return [Array<OM::Api::Resource>]
    #
    def delegations(opts={})
      get("/api/delegations", opts)
    end

    # Get a list of pending delegations for the user
    #
    # @return [Array<OM::Api::Resource>]
    #
    def pending_delegations(opts={})
      get("/api/delegations/pending", opts)
    end

    # Get a list of incoming delegations for the user
    #
    # @return [Array<OM::Api::Resource>]
    #
    def incoming_delegations(opts={})
      get("/api/delegations/incoming", opts)
    end

    # Get a list of pending incoming delegations for the user
    #
    # @return [Array<OM::Api::Resource>]
    #
    def pending_incoming_delegations(opts={})
      get("/api/delegations/incoming/pending", opts)
    end

    # Get a list of outgoing delegations for the user
    #
    # @return [Array<OM::Api::Resource>]
    #
    def outgoing_delegations(opts={})
      get("/api/delegations/outgoing", opts)
    end

    # Get a list of pending outgoing delegations for the user
    #
    # @return [Array<OM::Api::Resource>]
    #
    def pending_outgoing_delegations(opts={})
      get("/api/delegations/outgoing/pending", opts)
    end

    # Get a single delegation
    #
    # @param id [Integer] id of a delegation
    # @return [OM::Api::Resource]
    #
    def delegation(id)
      get("/api/delegations/#{id}")
    end

    # Accept an incomnig delegation
    #
    # @param id [Integer] id of the delegation to accept
    # @return [OM::Api::Resource] - the updated delegation
    #
    def accept_delegation(id)
      put("/api/delegations/#{id}/accept")
    end

    # Decline an incomnig delegation
    #
    # @param id [Integer] id of the delegation to accept
    # @return [OM::Api::Resource] - the updated delegation
    #
    def decline_delegation(id, note="")
      put("/api/delegations/#{id}/decline", { note: note } )
    end

    # Re-delegate an incomnig delegation
    #
    # @param id [Integer] id of the delegation to accept
    # @param opts [Hash]
    # @option opts [String] :email  Delegate to this e-mail address
    # @option opts [String] :slug   Delegate to this user
    # @option opts [String] :note   Delegation note
    #
    # @return [OM::Api::Resource] - the new delegation
    #
    def redelegate(id, opts={})
      raise "No delegation target" if !opts[:email] && !opts[:slug]
      post("/api/delegations/#{id}/redelegate", opts)
    end
  end
end
