class Dish < ApplicationRecord
  belongs_to :restaurant
  has_many :dish_tags
  has_many :tags, through: :dish_tags
  
  validates :name, presence: true
  validates :restaurant, presence: true

  # Can only have one of any particular tag
  # validates :tag, uniqueness: true

  # Dish.names - all the names of dishes
  scope :names, -> { pluck(:name) }
  # Dish.max_tags - single dish with the most tags
  scope :max_tags, -> { joins(:dish_tags).group(:dish_id).order("COUNT(dish_id) DESC").take }
  # Dish.untagged - dishes with no tags
  scope :tagged, -> { joins(:tags) }
  scope :untagged, -> { where.not(id: tagged) }
  # Dish.average_tag_count - average tag count for dishes
  scope :average_tag_count, -> { average(:tag_count) }

end
