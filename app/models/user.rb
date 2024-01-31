class User < ApplicationRecord
  has_many :bookings

  validates :email, presence: true
  validates :name, presence: true

  def toggle_chef!
    update(chef: !chef)
  end

  def chef?
    chef
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
