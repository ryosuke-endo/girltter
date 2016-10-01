FactoryGirl.define do
  factory :supplemental do
    sequence(:body) { |n| "MyText_#{n}"}
    supplementable_id 1
    supplementable_type "Love"
  end
end
