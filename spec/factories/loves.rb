FactoryGirl.define do
  factory :love do
    title 'foo'
    body 'bar'
    category_id 1
    user_id 1

    trait :with_user do
      association :user, factory: :user
    end
  end
end
