class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :chef


  def photo
    # Replace this with the actual logic at a later date
    "https://source.unsplash.com/random/#{self.id}"
  end

  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date, :date_cannot_be_in_the_past

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "Must be after the start date")
    end
  end

  def date_cannot_be_in_the_past
    return if start_date.blank? || end_date.blank?

    if start_date < Date.today || end_date < Date.today
      errors.add(:date, "Cannot be in the past")
    end
  end
end
