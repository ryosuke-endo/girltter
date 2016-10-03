FactoryGirl.define do
  factory :love do
    title 'foo'
    body 'bar'
    category_id 1
    member_id 1

    trait :with_member do
      association :member, factory: :member
    end
  end
end
