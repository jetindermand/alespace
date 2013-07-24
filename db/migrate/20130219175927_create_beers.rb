class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string :name
      t.integer :style
      t.integer :brewery
      t.decimal :abv
      t.text :desc
      t.integer :ibu

      t.timestamps
    end

    add_index :beers, :name
    add_index :beers, :brewery
  end
end
