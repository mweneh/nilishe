class ChangeUsertypeDefault < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :u_type, 0
  end
end