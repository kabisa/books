Given("I open the application") do
  visit '/'
end

When("I click the {string} button") do |locator|
  click_link_or_button locator
end

Then("I see the sign in page") do
  expect(current_path).to eql('/sign_in')
  # No navbar
  # Check if the page has a sign in form
end
