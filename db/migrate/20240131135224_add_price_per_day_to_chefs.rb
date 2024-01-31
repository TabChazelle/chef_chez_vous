class AddPricePerDayToChefs < ActiveRecord::Migration[7.1]
  def change
    add_column :chefs, :price_per_day, :decimal
  end
end
