FactoryBot.define do
  factory :item_image  do
    item_image   {File.open("#{Rails.root}/spec/fixtures/test_image.jpg")}
  end
end