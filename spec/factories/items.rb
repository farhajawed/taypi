FactoryBot.define do
  factory :item do
    title { "MyString" }
    description { "MyText" }
    image_url { "MyString" }
    artist { nil }
  end
end
