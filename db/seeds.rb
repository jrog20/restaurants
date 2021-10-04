# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 20 restaurants, each with 10 dishes. Each dish should have 3 tags. Total of 10-15 tags.

[
  "Peri's Palace", "Best Burger", "Famous Food", "Quasario", "Dinner Diner", 
  "Zoro", "Pizza Put", "Terri's Tavern", "Papa's", "Sweeties",
  "275 Restaurant", "Midway", "Sarah's House of Pizza", "Pasta One", "Whisker's Restaurant",
  "The Greenery", "The Riverway", "Ron's Italian Restaurant", "Cafe Sheri", "Axel"
].each do |name|
  r = Restaurant.create(name: name)
  {
    salad: ["vegetarian", "healthy", "gluten-free"],
    burger: ["meat", "main dish"],
    fries: ["vegetarian", "side", "potato"],
    chicken: ["meat", "main dish", "gluten-free"],
    tacos: ["spicy", "gluten-free", "meat"],
    clams: ["side", "appetizer", "seafood"],
    potato: ["side", "potato", "vegetarian", "gluten-free"],
    cheese: ["appetizer", "side", "vegetarian"],
    spaghetti: ["main dish", "meat", "pasta"],
    soup: ["side", "meat", "pasta"],
    beef: ["meat", "main dish", "gluten-free"],
    bread: ["side", "appetizer", "vegetarian"]
  }.each do |dish, tags|
    d = Dish.create(name: dish)
    tags.each do |tag|
      t = Tag.find_or_create_by(name: tag)
      d.tags << t
    end 
    r.dishes << d
  end
end
