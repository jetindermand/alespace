# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :beer do
    name "MyString"
    style ""
    brewery 1
    abv ""
    desc "MyString"
    ibu 1
  end
end
