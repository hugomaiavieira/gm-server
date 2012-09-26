# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :spent do
    amount 1.5
    description "MyString"
    category_id nil
    date "2012-09-26"
  end
end
