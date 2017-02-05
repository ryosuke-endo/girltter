FactoryGirl.define do
  factory :comment do
    body "MyText"
    name '匿子'
    topic_id '1'
    association :topic, factory: :topic
  end
end
