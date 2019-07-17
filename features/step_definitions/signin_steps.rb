Given("I open the application") do
  visit '/'
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
