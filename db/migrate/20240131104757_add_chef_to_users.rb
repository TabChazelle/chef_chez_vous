class AddChefToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :chef, :boolean, default: false
  end
end
