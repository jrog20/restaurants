class CreateDishTags < ActiveRecord::Migration[6.0]
  def change
    create_table :dish_tags do |t|
      t.references :dish
      t.references :tag

      t.timestamps
    end
  end
end
