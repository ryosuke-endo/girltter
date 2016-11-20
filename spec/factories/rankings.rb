FactoryGirl.define do
  factory :ranking do
    type ""
    rankable_id 1
    rankable_type "MyString"
    read_count 1
    start_on "2016-11-20 11:42:23"
  end
end
