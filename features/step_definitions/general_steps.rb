When('I click (the ){string}( button)') do |locator|
  click_link_or_button locator
end

When('I wait for {int} second(s)') { |n| sleep n }

Then("I'm in") do
  expect(current_path).to eql('/')

  within('nav') do
    expect(page).to have_no_link('Sign in')
    expect(page).to have_text(@user.email)
  end

  expect(page).to have_link('add')
end

Then('I should be (back )on the main page') { expect(current_path).to eql('/') }

Then("I'm out") do
  step 'I should be back on the main page'

  within('nav') do
    expect(page).to have_link('Sign in')
    expect(page).not_to have_text(@user.email)
  end

  expect(page).to have_text('You are now logged out')
  expect(page).not_to have_button('add')
end

Then('I see an error telling me I am not unauthorized') do
  expect(page).to have_text('You are not authorized to perform this operation')
end

Then('I see a snackbar with a message') do
  expect(page).to have_css('.snackbar.show')
end

Then('I expect to see {string}') { |text| expect(page).to have_content(text) }
