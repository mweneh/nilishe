class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :id, :title, :user, :description
  belongs_to :user
end
