Given("I'm adding a new book") do
  step %q(I signed in as a Kabisaan)
  step %q(I click the "add" button)
end

Given("there are {int} books") do |books_count|
  create_list :book, books_count
end

Given("there are {int} books with a download link") do |books_count|
  create_list :book, books_count, :ebook
end

Given("there are {int} books with a printed copy") do |books_count|
  create_list :book, books_count, :printed_book
end

Given("the following book(s):") do |table|
  table.map_column!('comments_count', false) { |c| c.to_i }
  table.map_column!('created_at', false)     { |c| Chronic.parse(c) }
  table.map_column!('published_on', false)   { |p| Chronic.parse(p) }

  table.hashes.each do |h|
    time = h.delete('created_at') || Time.current
    h['reedition'] = Book.find_by(title: h['reedition'])

    travel_to(time) do
      if h['link'].blank?
        create(:book, :printed_book, h)
      else
        create(:book, h)
      end
    end
  end
end

Given("the {book} is available at the following locations:") do |book, table|
  book.copies.clear

  table.hashes.each do |h|
    location = Location.find_by(city: h.delete('location'))
    number   = h.delete('copies')
    book.copies << build(:copy, location: location, number: number)
  end

  book.save
end

Given("I liked the book {string}") do |title|
  step %q(I choose "Books" from the navigation drawer)
  step %Q(I like the book "#{title}")
end

Given("I disliked the book {string}") do |title|
  step %q(I choose "Books" from the navigation drawer)
  step %Q(I dislike the book "#{title}")
end

When("I am viewing the details for {string}") do |title|
  step %q(I choose "Books" from the navigation drawer)
  step %Q(I expand the panel for "#{title}")
  step %q(I click "View Details")
end

When("I {like_or_dislike_icon} the book {string}") do |icon, title|
  within('.list-group-item', text: title) do
    click_on icon
  end
end

When("I delete the book") do
  click_on('more_vert')
  click_on('Delete')
end

When("I delete the book {string}") do |title|
  within('.list-group-item', text: title) do
    step %q(I delete the book)
  end
end

When("I undo deleting the book/comment") do
  within('.snackbar.show') do
    click_on('Undo')
  end
end

When("I choose the location {string} in the modal") do |city|
  within('.modal form') do
    select(city, from: 'Location')
  end
end

When("I click {string} in the modal") do |text|
  within('.modal form') do
    click_on(text)
  end
end

When("I try to add an empty book") do
  within('form') do
    click_on('Save')
  end
end

When("I add {int} copies of the book to the location {string}") do |copies_count, location|
  within('.form-group', text: 'Copies') do
    field = all('.nested-fields').last
    field.find_field('Location').select(location)
    field.find_field('Number').fill_in with: copies_count
  end
end

When("I add another location") do
  within('.form-group', text: 'Copies') do
    click_on('Add Copy')
  end
end

When("I remove the first location") do
  within('.form-group', text: 'Copies') do
    field = all('.nested-fields').first
    field.click_on('clear')
  end
end

When("I edit the book {string}") do |title|
  #step %Q(I expand the panel for "#{title}")


  within('.list-group-item', text: title) do
    click_on('more_vert')
    click_on('Edit')
  end
end

When("I expand the panel for {string}") do |title|
  find('.expansion-panel', text: title).click
end

When("I click on the writer {string} for the book {string}") do |writer_name, title|
  within('.list-group-item', text: title) do
    click_on(writer_name)
  end
end

Then("I {can_or_not}view the details for {string}") do |should_do, title|
  to_have_or_not_have = should_do ? 'to' : 'not_to'

  within('.list-group-item', text: title) do
    expect(page).send(to_have_or_not_have, have_link('View Details'))
  end
end

Then("I {do_or_not}see attributes for a(n) {book_type}") do |should_do, book_type|
  to_have_or_not_have = should_do ? 'to' : 'not_to'

  case book_type
  when 'ebook'
    expect(page).send(to_have_or_not_have, have_css('[data-book-type="Ebook"]'))
  when 'printed book'
    expect(page).send(to_have_or_not_have, have_css('[data-book-type="PrintedBook"]'))
    expect(page).send(to_have_or_not_have, have_select('Location', selected: Location.first.city, count: 1))
    expect(page).send(to_have_or_not_have, have_field('Number', with: 1, count: 1))
  end
end

Then("it's a printed book") do
  expect(page).to have_content(/printed book/i)
end

Then("it's an e-book") do
  expect(page).to have_content(/e-book/i)
end

Then("I {can_or_not}edit {string}") do |should_do, title|
  # Expand first
  #step %Q(I expand the panel for "#{title}")

  to_have_or_not_have = should_do ? 'to' : 'not_to'

  within('.list-group-item', text: title) do
    expect(page).send(to_have_or_not_have, have_link('Edit', visible: false))
  end
end

Then("I {should_or_should_not}see information about how many copies there are") do |should_do|
  to_have_or_not_have = should_do ? 'to' : 'not_to'
  expect(page).send(to_have_or_not_have, have_css('div', text: 'copies', visible: false))
end

Then("I am viewing the {book}") do |book|
  route         = book.model_name.singular_route_key
  expected_path = send("#{route}_path", book)

  expect(current_path).to eql(expected_path)
  expect(page).to have_content(book.title)
  expect(page).to have_content("#{book.num_of_pages} pages") if book.num_of_pages?
  expect(page).to have_content(book.summary) if book.summary?
  expect(page).to have_content("Published #{book.published_on.strftime('%Y-%m-%d')}") if book.published_on?
  expect(page).to have_content(book.tag_list.to_s)
  expect(page).to have_content("By #{book.writer_names.to_sentence}") if book.writers.any?
end

Then("I am adding a new book") do
  expect(page).to have_content('Create a new book')

  within('form') do
    expect(page).to have_button('Save')
  end
end

Then(/I am( not)? seeing the button for adding a new book/) do |negate|
  have_add_button = have_link('add', exact: true)
  negate ? expect(page).not_to(have_add_button) : expect(page).to(have_add_button)
end

Then("I can edit the book") do
  click_on('more_vert')
  expect(page).to have_link('Edit')
end

Then("I should see a list of {int} book(s)") do |items_count|
  if items_count.nonzero?
    within_list_group do
      expect(page).to have_css('div.list-group-item', count: items_count)
    end
  else
    expect(page).not_to have_css('.list-group')
  end
end

Then("I should see a list of {int} {book_type}") do |items_count, icon|
  within_list_group do
    expect(page).to have_css('div.list-group-item .material-icons', text: icon, count: items_count, visible: false)
  end
end

Then("I should see {int} download links") do |items_count|
  # Dropdown menu is rendered twice for every book.
  expect(page).to have_link('Download', count: 2*items_count, visible: false)
end

Then("I {should_or_should_not}see a download link") do |should_do|
  to_have_or_not_have = should_do ? 'to' : 'not_to'
  expect(page).send(to_have_or_not_have, have_css('.dropdown .dropdown-menu', text: 'Download', visible: false))
end

Then("I {should_or_should_not}see a link to a re-edition") do |should_do|
  to_have_or_not_have = should_do ? 'to' : 'not_to'
  expect(page).send(to_have_or_not_have, have_css('.alert', text: 'A newer edition for this book is available.'))
end


Then("I see there are {int} copies of the book") do |copies_count|
  expect(page).to have_text("#{copies_count} copies")
end

Then("I see the book {string} has {int} copy/copies left") do |title, copies_count|
  within('.list-group-item', text: title) do
    step %Q(I see the book has #{copies_count} copies left)
  end
end

Then("I see the book has {int} copy/copies left") do |copies_count|
  expect(page).to have_css('p', text: /#{copies_count} cop(y|ies)/, visible: false)
end

Then("I see a validation error that download link is required in case no copies are added") do
  within('form') do
    expect(page).to have_content('If you don\'t have any printed copies, you need to add a download link')
  end
end

Then("I see a validation error that duplicate locations are not allowed") do
  within('form') do
    expect(page).to have_content('must be unique')
  end
end

Then("I {should_or_should_not}see the summary for {string}") do |should_do, title|
  to_have_or_not_have = should_do ? 'to' : 'not_to'
  book = Book.find_by(title: title)

  within('.list-group-item', text: title) do
    expect(page).send(to_have_or_not_have, have_text(book.summary))
  end
end

Then("I {should_or_should_not}see a link to a re-edition for {string}") do |should_do, title|
  to_have_or_not_have = should_do ? 'to' : 'not_to'

  within('.list-group-item', text: title) do
    expect(page).send(to_have_or_not_have, have_css('h5 .badge', text: 're-edition available', visible: false))
    expect(page).send(to_have_or_not_have, have_css('.alert', text: 'A newer edition for this book is available.'))
  end
end

Then("I {do_or_not}see a {like_or_dislike_icon} button for the book {string}") do |should_do, icon, title|
  to_have_or_not_have = should_do ? 'to' : 'not_to'

  within('.list-group-item', text: title) do
    expect(page).send(to_have_or_not_have, have_button(icon))
  end
end

Then("I see {int} {likes_or_dislikes} the book {string}") do |int, like_or_dislike, title|
  within('.list-group-item', text: title) do
    expect(page).to have_css(".vote .#{like_or_dislike}", text: int)
  end
end

Then("I see {string} for the book {string}") do |text, title|
  within('.list-group-item', text: title) do
    expect(page).to have_content(text)
  end
end

Then("there are no more books to be shown") do
  within_list_group do
    expect(page).not_to have_css('a.list-group-item', text: 'More books')
  end
end
