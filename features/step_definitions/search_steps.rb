Then("I can search") do
  expect(page).to have_css('form input[type="search"]')
end


When("I search for {string}") do |q|
  within('form.book_search') do
    find('input[type="search"]').set(q)
    click_on('Search')
  end
end

Then("I see {string} is highlighted for the book {string}") do |q, title|
  within('.list-group-item', text: title) do
    expect(page).to have_css('mark', text: q)
  end
end
