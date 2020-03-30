# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "faker"

first_user = User.create(
  email: "test@example.com",
  password: "123456",
  nickname: "Jackradian",
  first_name: "Anh",
  last_name: "Nguyen"
)

10.times do
  User.create(
    email: Faker::Internet.email,
    password: "123456",
    nickname: Faker::Superhero.descriptor,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end

second_user = User.where.not(id: first_user.id).first
UserRelationship.create(user_one: first_user, user_two: second_user, relationship_type: :friends)
room = Room.create
room.participants.create(user: first_user)
room.participants.create(user: second_user)
