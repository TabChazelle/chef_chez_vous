# db/migrate/YYYYMMDDHHMMSS_add_default_to_chef_column.rb

class AddDefaultToChefColumn < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :chef, from: nil, to: false
  end
end
