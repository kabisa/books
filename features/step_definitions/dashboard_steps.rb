Then("I see the book {string} suggested as {string}") do |title, suggestion|
  expect(page).to have_content('Suggested for you')

  within('.suggestions .card', text: suggestion) do
    expect(page).to have_content(title)
  end
end

Then("I don't see any suggestions") do
  expect(page).not_to have_content('Suggested for you')
  expect(page).not_to have_css('.suggestions')
end


Then("I don't see a book suggested as {string}") do |suggestion|
  expect(page).not_to have_css('.suggestions .card', text: suggestion)
end
