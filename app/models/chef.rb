class Chef < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :reviews, dependent: :destroy

  geocoded_by :city
  after_validation :geocode, if: :will_save_change_to_address?

  def photo
    # Replace this with the actual logic at a later date
    "https://source.unsplash.com/featured/?#{self.id},chef,chefs"
  end

end
