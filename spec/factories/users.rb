FactoryGirl.define do
  pw = "helloworld"
  factory :user do
    sequence(:name){ |n| "user#{n}" }
    sequence(:email){ |n| "user#{n}@factory.com" }
    password pw
    password_confirmation pw
  end
end