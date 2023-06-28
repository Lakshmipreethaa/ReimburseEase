FactoryBot.define do
  factory :designation do
    name { Faker::Company.unique.name }
  end
end
