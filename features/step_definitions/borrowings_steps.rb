Given("the following borrowings:") do |table|
  table.map_column!('title')    { |title| Book.find_by(title: title) }
  table.map_column!('user')     { |email| User.find_by(email: email) }
  table.map_column!('location') { |city| Location.find_by(city: city) }

  table.hashes.each do |h|
    book = h['title']
    copy = book.copies.find { |c| c.location == h['location'] }
    copy.borrowings.create(user: h['user'])
  end
end
