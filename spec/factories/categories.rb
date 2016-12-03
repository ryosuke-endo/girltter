FactoryGirl.define do
  factory :category do
    name "恋愛相談"
    description "恋愛に関する相談を行う場所です"
    image File.new("#{Rails.root}/spec/fixtures/image/1.jpg")
  end
end
