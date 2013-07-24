# == Schema Information
#
# Table name: beers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  style      :integer
#  brewery    :integer
#  abv        :decimal(, )
#  desc       :text
#  ibu        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Beer < ActiveRecord::Base
  attr_accessible :abv, :brewery_id, :desc, :ibu, :name, :style

  validates :name, presence: true, uniqueness: { case_sensitive: false } 
  validates :brewery, presence: true

  belongs_to :brewery
  belongs_to :cellared_beers, dependent: :destroy
  #has_many :users, through: :cellared_beers

  default_scope order: 'beers.name ASC'
#  extend FriendlyId
#  friendly_id :name, use: [:slugged, :history]
end
