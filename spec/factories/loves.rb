FactoryGirl.define do
  factory :love do
    sequence :title do |n|
      "foo_#{n}"
    end
    sequence :body do |n|
      "bar_#{n}"
    end
    category_id 1
    member

    trait :with_member do
      association :member, factory: :member
    end

    trait :with_category do
      association :category, factory: :category
    end
  end
end
