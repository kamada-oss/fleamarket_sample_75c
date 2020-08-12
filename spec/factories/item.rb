FactoryBot.define do
  factory :item do
    id                    {1}
    name                  {"パンツ"}
    text                  {"メンズパンツです"}
    category_id           {1}
    condition             {1}
    fee_burden            {1}
    prefecture            {1}
    handling_time         {1}
    price                 {1000}
    user_id               {1} 
  end

  factory :category do
    name                  {"???"}
  end
end