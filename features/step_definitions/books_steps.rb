Then("I can add a new book") do
  expect(page).to have_content('Create a new book')
  within('form') do
    expect(page).to have_button('Save')
  end
end

