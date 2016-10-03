FactoryGirl.define do
  factory :member do
    sequence :login do |n|
      "mrennai_#{n}"
    end
    email { "#{SecureRandom.uuid}@example.com" }
    password 'password'
    password_confirmation 'password'
    crypted_password '5f4dcc3b5aa765d61d8327deb882cf99'
    salt "6RNPcfPsyUUe5QkEQfp8"
    type Member
  end
end
