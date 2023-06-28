FactoryBot.define do
  factory :department do
    name { Faker::Company.unique.name }
  end
end
