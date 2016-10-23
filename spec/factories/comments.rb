FactoryGirl.define do
  factory :comment do
    body "MyText"
    member_id 1
    commentable_id 1
    commentable_type "Love"
  end
end
