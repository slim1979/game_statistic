FactoryBot.define do
  factory :command do
    title { Faker::Company.name }
  end
end
