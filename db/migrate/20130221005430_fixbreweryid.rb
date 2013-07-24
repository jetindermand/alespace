class Fixbreweryid < ActiveRecord::Migration
  def up
  	rename_column :beers, :brewery, :brewery_id
  end

  def down
  end
end
