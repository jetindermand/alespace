class AddYearAndSizeToCellaredBeers < ActiveRecord::Migration
  def change
    add_column :cellared_beers, :year, :integer
    add_column :cellared_beers, :size, :string
  end
end
