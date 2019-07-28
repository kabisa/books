Given("I fill in {string} with {string}") do |locator, value|
  fill_in locator, with: value
end

Then("I see a validation error for {string}") do |label|
  within('form') do
    expect(page).to have_css('.form-group.form-group-invalid', text: label)
  end
end

