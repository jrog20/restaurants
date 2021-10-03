class Restaurant < ApplicationRecord
  has_many :dishes
  validates :name, presence: true
end
