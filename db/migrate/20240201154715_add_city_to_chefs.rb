class AddCityToChefs < ActiveRecord::Migration[7.1]
  def change
    add_column :chefs, :city, :string
  end
end
