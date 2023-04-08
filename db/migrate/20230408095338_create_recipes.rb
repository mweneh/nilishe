class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.belongs_to :user, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end