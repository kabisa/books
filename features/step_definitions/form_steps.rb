Given("I fill in {string} with {string}") do |locator, value|
  fill_in locator, with: value
end

When("I select {string} as {string}") do |value, name|
  choose value
end

Then("I {do_or_not}see a validation error for {string}") do |should_do, label|
  within('form') do
    to_have_or_not_have = should_do ? 'to' : 'not_to'
    expect(page).send(to_have_or_not_have, have_css('.form-group.form-group-invalid', text: label))
  end
end

