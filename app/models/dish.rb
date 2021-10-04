class Dish < ApplicationRecord
  belongs_to :restaurant
  has_many :dish_tags
  has_many :tags, through: :dish_tags
  
  validates :name, presence: true
  validates :restaurant, presence: true

  # Can only have one of any particular tag
  # validates :tag, uniqueness: true
end
