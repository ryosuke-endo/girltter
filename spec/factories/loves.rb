FactoryGirl.define do
  factory :love do
    sequence :title do |n|
      "foo_#{n}"
    end
    sequence :body do |n|
      "bar_#{n}"
    end
    category_id 1
    member_id 1

    trait :with_member do
      association :member, factory: :member
    end
  end
end
