FactoryGirl.define do
  factory :reaction do
    icon_id 1
    reactionable_id 1
    reactionable_type "Topic"
    user_cookie_value "20170312837ec5754f503cfaaee0929fd48974e7"
    association :icon, factory: :icon
  end
end
