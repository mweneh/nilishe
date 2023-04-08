class Meal < ApplicationRecord
    belongs_to :recipe
    belongs_to :meal_category
    belongs_to :country
    enum :status, {unpublished: 0, published: 1, deleted: 2}
  end