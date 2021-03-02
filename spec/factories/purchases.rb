FactoryBot.define do
  factory :purchase do
    postal_code    {"123-4456"}
    area_id        {2}
    municipalites  {"横浜市"}
    address        {"青山1-1"}
    building_name  {"森ビル"}
    phone_number   {"09012345678"}   
    token {"tok_abcdefghijk00000000000000000"}
  end
end
