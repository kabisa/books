Then("I see {int} comment(s)") do |comments_count|
  expect(page).to have_content(/#{comments_count} Comments?/)
  expect(page).to have_css('.comments li:not(.new-comment)', count: comments_count)
end

When("I comment with {string}") do |body|
  fill_in('comment[body]', with: body)
  click_on('Comment')
end
