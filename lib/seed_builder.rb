# This class is used by `db/seeds.rb` and makes it easier
# to understand to process in the seed.
class SeedBuilder
  include FactoryBot::Syntax::Methods if defined?(FactoryBot)
  include Rails.application.routes.url_helpers

  attr_reader :user_count, :books_count, :current_user

  def initialize
    @user_count = ENV.fetch('USERS_COUNT', 50).to_i
    @books_count = ENV.fetch('BOOKS_COUNT', 200).to_i
  end

  def truncate
    say('Truncate database.')
    truncate_books
    truncate_users
    truncate_locations
    truncate_writers
  end

  def create_locations
    %w(Weert Amsterdam Eindhoven).map { |city| Location.create(city: city) }
    say("Created #{Location.count} locations.")
  end

  def create_users
    create_list(:user, user_count, :random)
    create_current_user
    say("Created #{User.count} users.")
  end

  def create_books
    create_ebooks
    create_printed_books
  end

  def borrow_books
    Book.joins(:copies).each do |book|
      count = rand(book.copies.count)
      copies = book.copies.sample(count)
      borrowers = User.all.reload.sample(count)

      copies.each_with_index do |copy, i|
        borrower = borrowers[i]
        say("#{borrower} borrows #{copy}.")
        copy.borrowings.create(user: borrower)
      end
    end
  end

  def vote_books
    User.all.reload.each do |user|
      votes = :likes

      Book.all.sample(rand(Book.count)).in_groups(2, false) do |group|
        group.each do |book|
          say("#{user} #{votes} #{book}")
          book.send(votes).create(user: user)
        end

        votes = :dislikes
      end
    end
  end

  def comment_on_books
    User.all.reload.each do |user|
      Book.all.sample(rand(Book.count)).each do |book|
        say("#{user} comments on #{book}")
        create(:comment, :random, book: book, user: user)
      end
    end
  end

  def sign_in_url
    url = token_sign_in_url(current_user.login_token, host: 'localhost:3000')
    say "Start a Rails server and navigate to #{url}."
  end

  private

  def ebooks_count
    books_count/2
  end

  def truncate_books
    books = Book.with_deleted
    say("Deleting #{books.count} books.")
    books.each(&:really_destroy!)
  end

  def truncate_users
    say("Deleting users.")
    User.destroy_all
  end

  def truncate_locations
    say("Deleting locations.")
    Location.destroy_all
  end

  def truncate_writers
    say("Deleting writers.")
    Writer.destroy_all
  end

  def create_current_user
    STDOUT.puts "What's your email address?"
    email = STDIN.gets.strip.downcase
    @current_user = User.find_or_create_by!(attributes_for(:user, :random).merge(email: email))
  end

  def create_ebooks
    create_list(:book, ebooks_count, :ebook, :random)
    say("Created #{Book.count} e-books.")
  end

  def create_printed_books
    books_before_count = Book.count

    printed_books_count.times do
      book = build(:book, :printed_book, :random)
      book.copies.clear

      Location.all.each do |location|
        book.copies.build(location: location, number: rand(5))
      end

      book.save
    end

    say("Created #{books_before_count - Book.count} printed books.")
  end

  def say(message)
    puts message
  end

  alias :printed_books_count :ebooks_count
end
