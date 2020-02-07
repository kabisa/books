json.extract! book, :id, :title, :created_at, :updated_at
json.url book_url(book, format: :json)
json.description book.written_by_published_on
