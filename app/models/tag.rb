class Tag < ApplicationRecord
  has_many :dish_tags
  has_many :dishes, through: :dish_tags

  validate :name, :validate_name

  scope :grouped_by_tag_id, -> { joins(:dish_tags).group(:tag_id) }
  scope :ordered_by_popularity_desc, -> { grouped_by_tag_id.order("COUNT(dish_tags.dish_id) DESC") }
  scope :ordered_by_popularity_asc, -> { grouped_by_tag_id.order("COUNT(dish_tags.dish_id) ASC") }

  # tag with the most associated dishes
  scope :most_common, -> { ordered_by_popularity_desc.take }

  # tag with the fewest associated dishes
  scope :least_common, -> { ordered_by_popularity_asc.take }

  # all tags that have been used
  scope :used, -> { joins(:dish_tags).distinct } 

  # all tags that haven’t been used
  scope :unused, -> { where.not(id: used) }

  # all tags that have been used fewer than 5 times
  scope :uncommon, -> { grouped_by_tag_id.having("COUNT(dish_tags.dish_id) < ?", 5) }

  # top 5 tags by use
  scope :popular, -> { ordered_by_popularity_desc.take(5) }
  
  # restaurants that have this tag on at least one dish
  scope :restaurants_for_tag, -> (tag) { Restaurant.joins(:dishes => :tags).where("dish_tags.tag_id = ?", tag.id) }

  def restaurants
    Tag.restaurants_for_tag(self).distinct
  end

  # restaurant that uses this tag the most
  def top_restaurant
    Tag.restaurants_for_tag(self).group(:restaurant_id).order("COUNT(restaurant_id) DESC").take
  end

  private
  
  # Add validations to Tag name: Must be at least three characters,
  # and no more than two words
  def validate_name
    if name == nil || name.empty?
      errors.add(:name, "Must enter a name")
    elsif name.size < 3
      errors.add(:name, "Must be 3 or more characters")
      # match all words .scan(/\w+/)
    elsif name.scan(/\w+/).size > 2
      errors.add(:name, "Must be two words or less")
    end
  end
end
