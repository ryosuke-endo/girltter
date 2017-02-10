FactoryGirl.define do
  factory :topic do
    title "MyString"
    body "MyText"
    name "匿名さん"
    association :category, factory: :category
  end

  trait :with_comment do
    after(:create) do |topic|
      topic.comments << create(:comment, topic_id: topic.id)
    end
  end
end
