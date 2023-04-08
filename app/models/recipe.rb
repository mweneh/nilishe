class Recipe < ApplicationRecord
    belongs_to :user
    has_one :meal
    validates :title, { length: { minimum: 3 }, presence: true }
    validates :description, { length: { minimum: 15 }, presence: true }
  end