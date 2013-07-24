class CreateBreweries < ActiveRecord::Migration
  def change
#    drop_table :breweries
    create_table :breweries do |t|
      t.string :name
      t.string :desc
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.integer :zip
      t.integer :type
      t.string :web
      t.string :facebook
      t.string :twitter
      t.string :email
      t.string :phone

      t.timestamps
    end
    add_index :breweries, :name
  end
end
