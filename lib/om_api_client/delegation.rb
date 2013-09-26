module OM::Api

  # Methods for the OM delegation system
  #
  module Delegation

    # Get a list of delegations for the user
    #
    # @return [Array<Sawyer::Resource>]
    #
    def delegations
      get("/api/delegations")
    end

    # Get a list of pending delegations for the user
    #
    # @return [Array<Sawyer::Resource>]
    #
    def pending_delegations
      get("/api/delegations/pending")
    end

    # Get a list of incoming delegations for the user
    #
    # @return [Array<Sawyer::Resource>]
    #
    def incoming_delegations
      get("/api/delegations/incoming")
    end

    # Get a list of pending incoming delegations for the user
    #
    # @return [Array<Sawyer::Resource>]
    #
    def pending_incoming_delegations
      get("/api/delegations/incoming/pending")
    end

    # Get a list of outgoing delegations for the user
    #
    # @return [Array<Sawyer::Resource>]
    #
    def outgoing_delegations
      get("/api/delegations/outgoing")
    end

    # Get a list of pending outgoing delegations for the user
    #
    # @return [Array<Sawyer::Resource>]
    #
    def pending_outgoing_delegations
      get("/api/delegations/outgoing/pending")
    end

    # Get a single delegation
    #
    # @param id [Integer] id of a delegation
    #
    def delegation(id)
      get("/api/delegations/#{id}")
    end

    # Accept an incomnig delegation
    #
    # @params id [Integer] id of the delegation to accept
    #
    def accept_delegation(id)
      put("/api/delegations/#{id}/accept")
    end

    # Decline an incomnig delegation
    #
    # @params id [Integer] id of the delegation to accept
    #
    def decline_delegation(id, note="")
      put("/api/delegations/#{id}/decline", { note: note } )
    end

    # Re-delegate an incomnig delegation
    #
    # @params id [Integer] id of the delegation to accept
    # @params opts [Hash]
    # @option opts [String] :email  Delegate to this e-mail address
    # @option opts [String] :slug   Delegate to this user
    # @option opts [String] :note   Delegation note
    #
    def redelegate(id, opts={})
      raise "No delegation target" if !opts[:email] && !opts[:slug]
      post("/api/delegations/#{id}/redelegate", opts)
    end
  end
end
