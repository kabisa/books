# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# bin/rails db:seed USERS_COUNT=10 BOOKS_COUNT=100

say("Truncate database.")
books = Book.with_deleted
say("Deleting #{books.count} books.")
books.each(&:really_destroy!)

say("Deleting users.")
User.destroy_all
say("Deleting locations.")
Location.destroy_all

%w(Weert Amsterdam Eindhoven).map { |city| Location.create(city: city) }
say("Created #{Location.count} locations.")

if Rails.env.development?
  include FactoryBot::Syntax::Methods

  USER_COUNT = ENV.fetch('USERS_COUNT', 50).to_i
  BOOKS_COUNT = ENV.fetch('BOOKS_COUNT', 200).to_i
  EBOOKS_COUNT = BOOKS_COUNT/2
  PRINTED_BOOKS_COUNT = BOOKS_COUNT/2

  create_list(:user, USER_COUNT, :random)
  STDOUT.puts "What's your email address?"
  email = STDIN.gets.strip.downcase
  current_user = User.find_or_create_by!(attributes_for(:user, :random).merge(email: email))

  say("Created #{User.count} users.")

  create_list(:ebook, EBOOKS_COUNT, :random)
  say("Created #{Ebook.count} e-books.")

  PRINTED_BOOKS_COUNT.times do
    book = build(:printed_book, :random)
    book.copies.clear

    Location.all.each do |location|
      book.copies.build(location: location, number: rand(5))
    end

    book.save
  end

  say("Created #{PrintedBook.count} printed books.")

  PrintedBook.all.each do |book|
    count = rand(book.copies.count)
    copies = book.copies.sample(count)
    borrowers = User.all.sample(count)

    copies.each_with_index do |copy, i|
      borrower = borrowers[i]
      say("#{borrower} borrows #{copy}.")
      copy.borrowings.create(user: borrower)
    end
  end

  User.all.each do |user|
    votes = :likes

    Book.all.sample(rand(Book.count)).in_groups(2, false) do |group|
      group.each do |book|
        say("#{user} #{votes} #{book}")
        book.send(votes).create(user: user)
      end

      votes = :dislikes
    end
  end

  include Rails.application.routes.url_helpers
  url = token_sign_in_url(current_user.login_token, host: 'localhost:3000')
  say "Start a Rails server and navigate to #{url}."
end
