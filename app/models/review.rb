class Review < ApplicationRecord
  belongs_to :chef
  belongs_to :user
end
