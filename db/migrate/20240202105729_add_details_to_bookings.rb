class AddDetailsToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :special_requests, :text
    add_column :bookings, :number_of_guests, :integer
    add_column :bookings, :address, :string
  end
end
