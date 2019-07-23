Given("I open the application") do
  visit '/'
end

Given("I am on the Sign in page") do
  step %q(I open the application)
  step %q(I click the "Sign in" button)
end

Given("I sign up with my email address {string}") do |email|
  step %q(I am on the Sign in page)
  step %Q(I fill in "Email" with "#{email}")
  step %q(I click "Sign in")
end

Given("I signed in with my email address {string}") do |email|
  step %Q(I sign up with my email address "#{email}")
  step %q(I use the magic link)
end

Given("I click {string}") do |locator|
  click_link_or_button locator
end

When('I use the magic link') do
  @user = User.last
  visit token_sign_in_path(@user.login_token)
end

When("I click the {string} button") do |locator|
  click_link_or_button locator
end

When("I sign out") do
  within('nav') do
    click_on @user.email
    click_on 'Log out'
  end
end

Then("I see the sign in page") do
  expect(current_path).to eql('/sign_in')
  expect(page).not_to have_css('nav')
  expect(page).to have_text('Simply login with your email')
  expect(page).to have_field('Email')
  expect(page).to have_button('Sign in')
end

Then("I see a page with instructions for {string} how to login") do |email|
  expect(page).to have_text('Check your email!')
  expect(page).to have_text("We've emailed a special link to #{email}. Click the link to confirm your address and get started.")
end

Then("I'm in") do
  expect(current_path).to eql('/')

  within('nav') do
    expect(page).to have_no_link('Sign in')
    expect(page).to have_text(@user.email)
  end
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
end

Then("I see an error telling me I have entered an invalid email address") do
  expect(current_path).to eql('/sign_in')
  expect(page).to have_text('is not an email address')
end

Then("I see an error telling me my email address is unauthorized") do
  expect(current_path).to eql('/sign_in')
  expect(page).to have_text('is not authorized to sign in')
end

Then("I see an error telling me an email address is required") do
  expect(current_path).to eql('/sign_in')
  expect(page).to have_text('can\'t be blank')
end
