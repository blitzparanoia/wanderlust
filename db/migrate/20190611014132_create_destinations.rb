class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.string :city
      t.string :country
      t.integer :rating
      t.string :description

      t.timestamps null: false
    end
  end
end
