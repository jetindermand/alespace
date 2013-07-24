class AddQtyToCellaredBeers < ActiveRecord::Migration
  def change
    add_column :cellared_beers, :qty, :integer
  end
end
