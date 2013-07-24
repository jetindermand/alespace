# == Schema Information
#
# Table name: breweries
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  desc       :string(255)
#  address    :string(255)
#  city       :string(255)
#  state      :string(255)
#  country    :string(255)
#  zip        :integer
#  type       :integer
#  web        :string(255)
#  facebook   :string(255)
#  twitter    :string(255)
#  email      :string(255)
#  phone      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Brewery do
  pending "add some examples to (or delete) #{__FILE__}"
end
