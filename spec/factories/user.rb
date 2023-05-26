FactoryBot.define do
  factory :user, class: User do
    sequence(:email) { |n| "#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :user_admin, class: User, parent: :user do
    admin { true }
  end
end
