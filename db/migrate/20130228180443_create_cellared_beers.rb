class CreateCellaredBeers < ActiveRecord::Migration
  def change
    create_table :cellared_beers do |t|
      t.integer :user_id
      t.integer :beer_id

      t.timestamps
    end
    add_index :cellared_beers, :beer_id
    add_index :cellared_beers, :user_id
  end
end
