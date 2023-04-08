class CreateMeals < ActiveRecord::Migration[7.0]
  def change
    create_table :meals do |t|
      t.belongs_to :country, foreign_key: true
      t.string :description
      t.belongs_to :recipe, foreign_key: true
      t.string :tags
      t.string :ingredients
      t.belongs_to :category, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end