class Restaurant < ApplicationRecord
  has_many :dishes
  validates :name, presence: true

  # find the restaurant with the name 'Peri's Palace'
  def self.peri
    Restaurant.find_by(name: "Peri's Palace")
  end

  # find the tenth restaurant
  def self.tenth
    Restaurant.find(10)
  end

  # find all the restaurants with names longer than 12 chars
  def self.with_long_names
    where('LENGTH(name) > 12')
  end

  # find all the restaurants with fewer than 5 dishes
  def self.focused
    joins(:dishes).having('COUNT(dishes.id) < 5').group(:restaurant_id)
  end

  # find all the restaurants with more than 20 dishes
  def self.large_menu
    joins(:dishes).having('COUNT(dishes.id) > 20').group(:restaurant_id)
  end

  # all restaurants where the name is like the name passed in
  def self.name_like(name)
    where("name LIKE ?", "%#{name}%") 
  end

  # all restaurants where the name is not like the name passed in
  def self.name_not_like(name)
    where.not(id: name_like(name))
  end
end
