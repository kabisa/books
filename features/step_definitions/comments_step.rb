Then("I see {int} comments") do |comments_count|
  expect(page).to have_css('.comments li', count: comments_count)
end
