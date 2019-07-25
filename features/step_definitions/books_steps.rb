Given("I'm adding a new book") do
    step %q(I signed in as a Kabisaan)
    step %q(I click the "add" button)
end

Then("I am viewing the book") do
  book = Book.last

  expect(current_path).to eql("/books/#{book.id}")
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
