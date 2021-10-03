class Dish < ApplicationRecord
  validates :name, presence: true
  has_many :tags
end
