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

Given("I borrowed the book {string} {int} days ago") do |title, days_ago|
  travel_to(days_ago.days.ago) do
    step %q(I choose "Books" from the navigation drawer)
    step %Q(I borrow the book "#{title}")
  end
end

When("I borrow the book {string}") do |title|
  step %Q(I expand the panel for "#{title}")

  within('.list-group-item', text: title) do
    click_on('more_vert')
    click_on('Borrow')
  end
end

When("I borrow the book {string} from {string}") do |title, location|
  step %Q(I expand the panel for "#{title}")

  within('.list-group-item', text: title) do
    click_on('more_vert')
    first('li', text: 'Borrow').hover
    click_on(location)
  end
end

Then("I see feedback about borrowing the book {string}") do |title|
  within('.snackbar') do
    expect(page).to have_content("You're now borrowing '#{title}'.")
  end
end

Then("I see feedback about returning the book {string}") do |title|
  within('.snackbar') do
    expect(page).to have_content("Thank you for returning '#{title}'.")
  end
end

Then("I {can_or_not}borrow {string}") do |should_do, title|
  to_have_or_not_have = should_do ? 'to' : 'not_to'

  within('.list-group-item', text: title) do
    expect(page).send(to_have_or_not_have, have_button('Borrow', visible: false))
  end
end
