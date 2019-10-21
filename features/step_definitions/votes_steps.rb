Given("the following votes:") do |table|
  table.map_column!('title')       { |title| Book.find_by(title: title) }
  table.map_column!('liked by', false)    { |emails| User.where(email: emails.split) }
  table.map_column!('disliked by', false) { |emails| User.where(email: emails.split) }

  table.hashes.each do |h|
    book = h['title']
    book.likes.create(h['liked by'].map { |u| { user: u } })
    book.dislikes.create(h['disliked by'].map { |u| { user: u } }) if h['disliked by']
  end
end
