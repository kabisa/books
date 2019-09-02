Given("I'm adding a new book") do
  step %q(I signed in as a Kabisaan)
  step %q(I click the "add" button)
end

Given("there are {int} books") do |books_count|
  create_list :book, books_count
end

Given("there are {int} e-books") do |books_count|
  create_list :ebook, books_count
end

Given("there are {int} printed books") do |books_count|
  create_list :printed_book, books_count
end

When("I try to add an empty book") do
  within('form') do
    click_on('Save')
  end
end

Then("I {do_or_not}see attributes for a(n) {book_type}") do |should_do, book_type|
  to_have_or_not_have = should_do ? 'to' : 'not_to'

  case book_type
  when 'ebook'
    expect(page).send(to_have_or_not_have, have_css('[data-book-type="Ebook"]'))
  when 'printed book'
    expect(page).send(to_have_or_not_have, have_css('[data-book-type="PrintedBook"]'))
    expect(page).send(to_have_or_not_have, have_field('Location', count: 1))
    #expect(page).send(to_have_or_not_have, have_field('Number of books', count: 1))
  end
end

Then("it's a printed book") do
  expect(page).to have_content(/printed book/i)
end

Then("it's an e-book") do
  expect(page).to have_content(/e-book/i)
end


Then("I {can_or_not}download the book") do |should_do|
  book                = Book.last
  to_have_or_not_have = should_do ? 'to' : 'not_to'
  expect(page).send(to_have_or_not_have, have_link('cloud_download', href: book.link))
end

Then("I am viewing the book") do
  # pathname includes model name, e.g. `/ebooks/1` or `/printed_books/2`
  book          = Book.last
  route         = book.model_name.singular_route_key
  expected_path = send("#{route}_path", book)

  expect(current_path).to eql(expected_path)
  expect(page).to have_content(book.title)
end

Then("I am adding a new book") do
  expect(page).to have_content('Create a new book')

  within('form') do
    expect(page).to have_button('Save')
  end
end

Then(/I am( not)? seeing the button for adding a new book/) do |negate|
  have_add_button = have_link('add')
  negate ? expect(page).not_to(have_add_button) : expect(page).to(have_add_button)
end

Then("I can edit the book") do
  expect(page).to have_link('Edit')
end

Then("I see a list of {int} books") do |items_count|
  within('.list-group') do
    expect(page).to have_css('.list-group-item', count: items_count)
  end
end

Then("I see a list of {int} {book_type}") do |items_count, type|
  within('.list-group') do
    expect(page).to have_css('.list-group-item', text: /#{type}/i, count: items_count)
  end
end


Then("I see {int} download links") do |items_count|
  expect(page).to have_link('cloud_download', count: items_count)
end
