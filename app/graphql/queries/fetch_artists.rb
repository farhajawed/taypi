module Queries
  class FetchArtists < Queries::BaseQuery
    type [Types::ArtistType], null: false

    def resolve
      Artist.all
    end
  end
end
