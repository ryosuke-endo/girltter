FactoryGirl.define do
  factory :icon do
    image File.new("#{Rails.root}/spec/fixtures/image/1.jpg")
  end
end
