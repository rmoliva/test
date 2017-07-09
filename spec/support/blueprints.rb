# encoding: utf-8
# frozen_string_literal: true

require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

User.blueprint do
  email   { Faker::Internet.email }
  name    { Faker::Name.name }
  surname { Faker::Lorem.characters(250) }
  active  { true }

  pwd = Faker::Lorem.characters(50)
  password              { pwd }
  password_confirmation { pwd }
end

Product.blueprint do
  name    { Faker::Name.name }
  price   { Faker::Number.decimal(3, 4) }
  rating  { Faker::Number.between(0, 5) }
end
