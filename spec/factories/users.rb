# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@example.com" }
    sequence(:name, 'name_')
    password { 'password' }
    password_confirmation { 'password' }
    sequence(:introduction, 'introduction_1')
  end
end
