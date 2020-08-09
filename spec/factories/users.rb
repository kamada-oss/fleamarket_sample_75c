FactoryBot.define do
  factory :user do
    nickname              {"テスト太郎"}
    email                 {"aaa@aaa.com"}
    password              {"aaaaaaa"}
    password_confirmation {"aaaaaaa"}
    family_name           {"田中"}
    first_name            {"太郎"}
    family_name_kana      {"タナカ"}
    first_name_kana       {"タロウ"}
    birthday              {20200726}
    introduction          {"宜しくお願いします！"}
  end
end