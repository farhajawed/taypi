module Mutations
  module ItemModule
    extend ActiveSupport::Concern
    include GraphQL::Schema::Member::GraphQLTypeNames

    included do
      field :create_item, Types::ItemType, null: false do
        argument :title, String, required: true
        argument :description, String, required: false
        argument :image_url, String, required: false
        argument :artist_id, Integer, required: true
      end

      field :update_item, Types::ItemType, null: false do
        argument :id, ID, required: true
        argument :title, String, required: false
        argument :description, String, required: false
        argument :image_url, String, required: false
        argument :artist_id, Integer, required: false
      end

      field :delete_item, Boolean, null: false do
        argument :id, ID, required: true
      end
    end

    def create_item(title:, description: nil, image_url: nil, artist_id:)
      Item.create!(
        title: title,
        description: description,
        image_url: image_url,
        artist_id: artist_id
      )
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid attributes for Item: #{e.record.errors.full_messages.join(', ')}")
    end

    def update_item(id:, title: nil, description: nil, image_url: nil, artist_id: nil)
      item = Item.find(id)
      item.update!(
        title: title,
        description: description,
        image_url: image_url,
        artist_id: artist_id
      )
      item
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid attributes for Item: #{e.record.errors.full_messages.join(', ')}")
    end

    def delete_item(id:)
      item = Item.find(id)
      item.destroy!
      true
    rescue ActiveRecord::RecordNotFound => e
      GraphQL::ExecutionError.new("Item not found: #{e.message}")
    rescue ActiveRecord::RecordNotDestroyed => e
      GraphQL::ExecutionError.new("Failed to delete Item: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end

# mutation {
#   createItem(
#     title: "New Item",
#     description: "This is a description",
#     imageUrl: "http://example.com/image.jpg",
#     artistId: 1
#   ) {
#     id
#     title
#     description
#     imageUrl
#     artist {
#       id
#       fullName
#     }
#     createdAt
#     updatedAt
#   }
# }

