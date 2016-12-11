FactoryGirl.define do
  factory :topic do
    title "MyString"
    body "MyText"
    name "匿名さん"
    association :category, factory: :category
  end
end
