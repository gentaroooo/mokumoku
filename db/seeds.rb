# frozen_string_literal: true

require "./db/environment/#{Rails.env.downcase}.rb"

100.times do |n|
  User.create!(
    name: Faker::Games::Pokemon.name,
    email: Faker::Internet.email,
    password: '12345678',
    password_confirmation: '12345678'
)
end

#   User.create!(
#     name: "test",
#     email: "a@yahoo.co.jp",
#     password: 'going212',
#     password_confirmation: 'going212'
# )

100.times do |n|
  Event.create!(
    title:  Faker::Company.name,
    content: "test#{n + 1}回目",
    held_at: '2022-08-30 16:17:00',
    prefecture_id: Faker::Number.between(from: 1, to: 10),
    user_id: Faker::Number.between(from: 1, to: 10)
)
end