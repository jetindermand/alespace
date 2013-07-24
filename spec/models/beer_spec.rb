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

require 'spec_helper'

describe Beer do
  pending "add some examples to (or delete) #{__FILE__}"
end
