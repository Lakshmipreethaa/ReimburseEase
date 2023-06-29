FactoryBot.define do
  factory :designation do
    name { Faker::Company.unique.name }
    id { Faker::Number.unique.number }
    created_at { DateTime.now }
    updated_at { DateTime.now }
  end
end
