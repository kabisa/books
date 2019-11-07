# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# bin/rails db:seed USERS_COUNT=10 BOOKS_COUNT=100
#
# This seed only runs on development or if FORCE=true is added:
#
# bin/rails db:seed USERS_COUNT=10 BOOKS_COUNT=100 FORCE=true
require 'seed_builder'

builder = SeedBuilder.new

builder.truncate
builder.create_locations

if Rails.env.development? || ENV['FORCE']
  builder.create_users
  builder.create_books
  builder.borrow_books
  builder.vote_books
  builder.comment_on_books
  builder.sign_in_url
end
