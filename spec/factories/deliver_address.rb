FactoryBot.define do
  factory :deliver_address do
    family_name           {"田中"}
    first_name            {"太郎"}
    family_name_kana      {"タナカ"}
    first_name_kana       {"タロウ"}
    zip_code              {1234567}
    prefecture            {"神奈川県"}
    city                  {"横浜市緑区"}
    address1              {"青山1-1-1"}
    address2              {"柳ビル３階"}
    phone_number          {"09012345678"}
    user_id               {1}
  end
end