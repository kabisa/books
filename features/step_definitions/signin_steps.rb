Given("I open the application") do
  visit '/'
end

Given("I am on the Sign in page") do
  step %q(I open the application)
  step %q(I click the "Sign in" button)
end

When("I click the {string} button") do |locator|
  click_link_or_button locator
end

Then("I see the sign in page") do
  expect(current_path).to eql('/sign_in')
  expect(page).not_to have_css('nav')
  expect(page).to have_text('Simply login with your email')
  expect(page).to have_field('Email')
  expect(page).to have_button('Sign in')
end

Given("I click {string}") do |locator|
  click_link_or_button locator
end

Then("I see a page with instructions for {string} how to login") do |email|
  expect(page).to have_text('Check your email!')
  expect(page).to have_text("We've emailed a special link to #{email}. Click the link to confirm your address and get started.")
end
