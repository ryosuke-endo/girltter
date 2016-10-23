FactoryGirl.define do
  factory :supplemental do |supplemental|
    sequence(:body) { |n| "MyText_#{n}"}

    trait :with_love do
      supplemental.supplementable { |s| s.association(:love) }
    end
  end
end
