Then("I can search") do
  expect(page).to have_css('form input[type="search"]')
end
