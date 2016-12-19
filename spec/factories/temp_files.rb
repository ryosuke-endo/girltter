FactoryGirl.define do
  factory :temp_file do
    temp File.new("#{Rails.root}/spec/fixtures/image/1.jpg")
  end
end
