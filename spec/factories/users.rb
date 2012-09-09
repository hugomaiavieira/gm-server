# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@mail.com" }
    password '123456'
    password_confirmation '123456'
    sequence(:authentication_token)
  end
end
