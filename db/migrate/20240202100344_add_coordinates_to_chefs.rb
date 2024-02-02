class AddCoordinatesToChefs < ActiveRecord::Migration[7.1]
  def change
    add_column :chefs, :latitude, :float
    add_column :chefs, :longitude, :float
  end
end
