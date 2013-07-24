class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :trackable, polymorphic: true

  has_one :micropost, primary_key: "trackable_id",
  					  foreign_key: "id"
  has_one :relationship, primary_key: "trackable_id",
  					     foreign_key: "id"
  has_one :cellared_beer, primary_key: "trackable_id",
  					     foreign_key: "id"

  attr_accessible :action, :trackable
end
