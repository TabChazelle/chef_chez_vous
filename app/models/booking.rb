class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :chef

  def photo
    # Replace this with the actual logic at a later date
    "https://source.unsplash.com/random/#{self.id}"
  end

end
