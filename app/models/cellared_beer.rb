class CellaredBeer < ActiveRecord::Base
  attr_accessible :beer_id, :year, :size, :qty
  
  belongs_to :activity
  belongs_to :user, primary_key: "user_id",
  					foreign_key: "id"
  has_one :beer, primary_key: "beer_id",
  				 foreign_key: "id"

  def self.add_to_cellar(user_id, beer_id, year, size, quantity)
    cb = where(user_id: user_id, beer_id: beer_id, year: year, size: size).first_or_initialize(qty: 0)
    cb.qty += quantity
    cb.save!
    cb
  end 
end
