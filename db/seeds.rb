# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Book.with_deleted.each(&:really_destroy!)
User.destroy_all
Location.destroy_all

%w(Weert Amsterdam Eindhoven).map { |city| Location.create(city: city) }

if Rails.env.development?
  include FactoryBot::Syntax::Methods

  USER_COUNT = 50
  EBOOKS_COUNT = 20#0
  PRINTED_BOOKS_COUNT = 20#0

  STDOUT.puts "What's your email address?"
  email = STDIN.gets.strip.downcase
  User.create!(email: email)

  create_list(:user, USER_COUNT, :random)
  say("Created #{USER_COUNT} users.")

  EBOOKS_COUNT.times do
    create(:ebook, :random)
  end
  say("Created #{EBOOKS_COUNT} e-books.")

  PRINTED_BOOKS_COUNT.times do
    book = build(:printed_book, :random)
    book.copies.clear
    Location.all.each do |location|
      book.copies.build(location: location, number: rand(5))
    end
    book.save
  end

  say("Created #{PRINTED_BOOKS_COUNT} printed books.")

  PrintedBook.all.each do |book|
    count = rand(book.copies.count)
    copies = book.copies.sample(count)
    borrowers = User.all.sample(count)

    copies.each_with_index do |copy, i|
      borrower = borrowers[i]
      say("#{borrower} borrows #{copy}")
      copy.borrowings.create(user: borrower)
    end
  end

  User.all.each do |user|
    votes = :likes

    Book.all.sample(rand(Book.count)).in_groups(2, false) do |group|
      group.each do |book|
        book.send(votes).create(user: user)
      end

      votes = :dislikes
    end
  end
end
