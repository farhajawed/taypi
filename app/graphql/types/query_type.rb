# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
  
    field :fetch_items, resolver: Queries::FetchItems, description: "Return a list of items"
    field :fetch_artists, resolver: Queries::FetchArtists, description: "Return a list of artists"
  end
end
