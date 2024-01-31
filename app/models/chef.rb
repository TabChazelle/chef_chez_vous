class Chef < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :reviews, dependent: :destroy


  def photo
    # Replace this with the actual logic at a later date
    "https://source.unsplash.com/random/#{self.id}"
  end

end
