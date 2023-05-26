FactoryBot.define do
  factory :location, class: Location do
    sequence(:name) { |n| "location_name_#{n}" }
    sequence(:russian_name) { |n| "русское_название_#{n}" }
    location_type { 'city' }
    lat { '44.34' }
    lon { '10.99' }
  end
end
