Then("I can search") do
  expect(page).to have_css('form input[type="search"]')
end


When("I search for {string}") do |q|
  within('form.book_search') do
    find('input[type="search"]').set(q)
    click_on('Search')
  end
end

