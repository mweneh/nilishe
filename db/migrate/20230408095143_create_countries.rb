class CreateCountries < ActiveRecord::Migration[7.0]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :official_language
      t.integer :code

      t.timestamps
    end
  end
end
