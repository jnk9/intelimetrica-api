class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.integer :rating, limit: 4
      t.string :name
      t.string :site
      t.string :email
      t.string :phone
      t.string :street
      t.string :city
      t.string :state
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
