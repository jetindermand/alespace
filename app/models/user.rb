# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string(255)
#

class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
  has_many :microposts, dependent: :destroy

  has_many :activities
  
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :followed_users, through: :relationships, source: :followed

  has_many :cellared_beers, dependent: :destroy
  #has_many :beers, through: :cellared_beers

  def feed
    Micropost.from_users_followed_by(self)
  end

# Following users
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

# Cellar beer stuff
  def cellaring?(beer, year, size)
    cellared_beers.where(:beer_id=>beer.id).where(:year=>year).where(:size=>size)
  end

  def cellar!(beer, year, size, qty)
    cb = cellared_beers.where(:beer_id=>beer.id, :year=>year, :size=>size).first_or_initialize
    if cb.qty.to_s.empty?
      cb.qty = qty
    else
      cb.qty += qty
    end
    cb.save
  end

  def uncellar!(beer)
    cellared_beers.find_by_beer_id(beer.id).destroy
  end

end
