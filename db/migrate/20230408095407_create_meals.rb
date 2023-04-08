class CreateMeals < ActiveRecord::Migration[7.0]
  def change
    create_table :meals do |t|
      t.integer :country
      t.string :description
      t.integer :recipe
      t.string :tags
      t.string :ingredients
      t.integer :category
      t.integer :status

      t.timestamps
    end
  end
end
