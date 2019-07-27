When("I click (the ){string}( button)") do |locator|
  click_link_or_button locator
end

Given("I open the application") do
  visit '/'
end

Given("I navigate to page for adding a new book") do
  visit(new_book_path)
end

Then("I'm in") do
  expect(current_path).to eql('/')

  within('nav') do
    expect(page).to have_no_link('Sign in')
    expect(page).to have_text(@user.email)
  end

  expect(page).to have_link('add')
end

Then("I'm (back )on the main page") do
  expect(current_path).to eql('/')
end

Then("I'm out") do
  step %q(I'm on the main page)

  within('nav') do
    expect(page).to have_link('Sign in')
    expect(page).not_to have_text(@user.email)
  end

  expect(page).to have_text('You are now logged out')
  expect(page).not_to have_button('add')
end

Then("I see an error telling me I am not unauthorized") do
  expect(page).to have_text('You are not authorized to perform this operation')
end
