
When("I sort on {string}") do |label|
  click_on('Sort by')
  click_on(label)
end

Then("I see {string} as the first book") do |title|
  el = first('.list-group-item')

  expect(el).to have_content(title)
end

Then("I see {string} as the last book") do |title|
  el = all('.list-group-item').last

  expect(el).to have_content(title)
end
