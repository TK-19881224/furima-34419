FactoryBot.define do
  factory :user do
    nickname {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password {'1a'+Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    lastname_ja {"田中"}
    firstname_ja {"太郎"}
    lastname_ka {"タナカ"}
    firstname_ka  {"タロウ"} 
    birth_date  {"2021-02-15"}
  end
end