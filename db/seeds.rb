# encoding: utf-8
# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the
# db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create one test user
test_name = 'Juan'
test_surname = 'Lopez'
test_email = 'test@test.com'
test_password = '12345678'

User.where(
  email: test_email
).first_or_create! do |record|
  record.name = test_name
  record.surname = test_surname
  record.email = test_email
  record.password = test_password
  record.password_confirmation = test_password
end

50.times do |i|
  name = "Product#{i}"

  Product.where(
    name: name
  ).first_or_create! do |record|
    record.name = name
    record.price = Faker::Number.decimal(3, 4)
    record.rating = Faker::Number.between(0, 5)
  end
end
