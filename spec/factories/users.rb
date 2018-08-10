require 'bcrypt'

FactoryBot.define do
  factory :user do
    username { FFaker::Internet.user_name }
    password_digest BCrypt::Password.create('password')
  end
end