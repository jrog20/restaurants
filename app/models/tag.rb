class Tag < ApplicationRecord
  has_many :dish_tags
  has_many :dishes, through: :dish_tags

  validate :name, :validate_name

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
